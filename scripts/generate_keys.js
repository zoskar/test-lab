#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

/**
 * Parse keys configuration file and generate Dart keys file
 */
function generateKeysFile() {
    const inputFile = path.join(__dirname, '..', 'lib', 'keys.js');
    const outputFile = path.join(__dirname, '..', 'lib', 'keys.g.dart');

    if (!fs.existsSync(inputFile)) {
        console.error('Error: keys.js file not found at', inputFile);
        process.exit(1);
    }

    try {
        const content = fs.readFileSync(inputFile, 'utf8');
        const dartContent = parseAndGenerateDart(content);

        fs.writeFileSync(outputFile, dartContent);
        console.log('Successfully generated keys.g.dart');
    } catch (error) {
        console.error('Error generating keys file:', error.message);
        process.exit(1);
    }
}

/**
 * Parse JavaScript configuration and generate Dart content
 */
function parseAndGenerateDart(content) {
    try {
        const properties = parseJavaScriptConfig(content);
        return generateDartCode(properties);
    } catch (error) {
        throw new Error(`Failed to parse configuration file: ${error.message}`);
    }
}



/**
 * Parse JavaScript module.exports configuration
 */
function parseJavaScriptConfig(content) {
    // Remove comments and clean up
    const cleanContent = content.replace(/\/\*[\s\S]*?\*\//g, '').replace(/\/\/.*$/gm, '');

    // Extract module.exports
    const objectMatch = cleanContent.match(/module\.exports\s*=\s*(\{[\s\S]*\})/);

    if (!objectMatch) {
        throw new Error('Could not find module.exports in keys.js');
    }

    // Use eval to parse the object (safe for controlled config files)
    try {
        const objectString = objectMatch[1];
        const configObject = eval(`(${objectString})`);
        return configObject;
    } catch (error) {
        throw new Error(`Failed to parse JavaScript object: ${error.message}`);
    }
}

/**
 * Parse static properties from class body
 */
function parseProperties(classBody) {
    const properties = {};

    // Match static property declarations
    const staticRegex = /static\s+(\w+):\s*\{([^}]*)\}/g;
    let match;

    while ((match = staticRegex.exec(classBody)) !== null) {
        const propertyName = match[1];
        const propertyBody = match[2];

        properties[propertyName] = parseNestedObject(propertyBody);
    }

    return properties;
}

/**
 * Parse nested object properties with improved nested object handling
 */
function parseNestedObject(objectBody, depth = 0) {
    const properties = {};

    // Clean and tokenize the object body
    const tokens = tokenizeObjectBody(objectBody);
    let i = 0;

    while (i < tokens.length) {
        const token = tokens[i];

        if (token.type === 'property') {
            const propertyName = token.name;
            const propertyType = token.valueType;

            if (propertyType === 'string') {
                properties[propertyName] = 'string';
            } else if (propertyType === 'object') {
                // Parse nested object
                const nestedTokens = token.nestedTokens;
                properties[propertyName] = parseNestedObject(reconstructObjectBody(nestedTokens), depth + 1);
            }
        }

        i++;
    }

    return properties;
}

/**
 * Tokenize object body into structured tokens
 */
function tokenizeObjectBody(objectBody) {
    const tokens = [];
    const lines = objectBody.split('\n');

    for (let i = 0; i < lines.length; i++) {
        const line = lines[i].trim();
        if (!line || line === '') continue;

        // Handle simple string properties
        const stringMatch = line.match(/(\w+):\s*string[;,]?/);
        if (stringMatch) {
            tokens.push({
                type: 'property',
                name: stringMatch[1],
                valueType: 'string'
            });
            continue;
        }

        // Handle nested object properties
        const nestedMatch = line.match(/(\w+):\s*\{/);
        if (nestedMatch) {
            const propertyName = nestedMatch[1];
            const nestedBody = extractNestedObjectFromLines(lines, i);
            const nestedTokens = tokenizeObjectBody(nestedBody);

            tokens.push({
                type: 'property',
                name: propertyName,
                valueType: 'object',
                nestedTokens: nestedTokens
            });

            // Skip the lines we've already processed
            i += countNestedLines(lines, i);
        }
    }

    return tokens;
}

/**
 * Extract nested object body from lines starting at a given index
 */
function extractNestedObjectFromLines(lines, startIndex) {
    let braceCount = 0;
    let result = '';
    let capturing = false;

    for (let i = startIndex; i < lines.length; i++) {
        const line = lines[i];

        if (line.includes('{')) {
            braceCount += (line.match(/\{/g) || []).length;
            if (!capturing) {
                capturing = true;
                continue; // Skip the line with the opening brace
            }
        }

        if (line.includes('}')) {
            braceCount -= (line.match(/\}/g) || []).length;
            if (braceCount === 0) {
                break;
            }
        }

        if (capturing) {
            result += line + '\n';
        }
    }

    return result;
}

/**
 * Count how many lines are consumed by a nested object
 */
function countNestedLines(lines, startIndex) {
    let braceCount = 0;
    let count = 0;

    for (let i = startIndex; i < lines.length; i++) {
        const line = lines[i];

        if (line.includes('{')) {
            braceCount += (line.match(/\{/g) || []).length;
        }

        if (line.includes('}')) {
            braceCount -= (line.match(/\}/g) || []).length;
            if (braceCount === 0) {
                break;
            }
        }

        if (i > startIndex) {
            count++;
        }
    }

    return count;
}

/**
 * Reconstruct object body from tokens
 */
function reconstructObjectBody(tokens) {
    let result = '';

    for (const token of tokens) {
        if (token.valueType === 'string') {
            result += `${token.name}: string;\n`;
        } else if (token.valueType === 'object') {
            result += `${token.name}: {\n${reconstructObjectBody(token.nestedTokens)}\n};\n`;
        }
    }

    return result;
}

/**
 * Extract the body of a nested object
 */
function extractNestedObjectBody(fullBody, startLine) {
    const lines = fullBody.split('\n');
    let braceCount = 0;
    let capturing = false;
    let result = '';

    for (let line of lines) {
        if (line.trim() === startLine.trim()) {
            capturing = true;
            braceCount = 1;
            continue;
        }

        if (capturing) {
            const openBraces = (line.match(/\{/g) || []).length;
            const closeBraces = (line.match(/\}/g) || []).length;

            braceCount += openBraces - closeBraces;

            if (braceCount === 0) {
                break;
            }

            result += line + '\n';
        }
    }

    return result;
}

/**
 * Generate Dart code from parsed properties
 */
function generateDartCode(properties) {
    let dartCode = "import 'package:flutter/widgets.dart';\n\n";

    // Generate a single generic TestKey class instead of multiple hardcoded ones
    dartCode += `class TestKey extends ValueKey<String> {\n`;
    dartCode += `  const TestKey(super.value);\n`;
    dartCode += `}\n\n`;

    // Generate concrete classes for all nested structures
    const allClasses = collectAllClasses(properties);

    // Identify top-level classes (those that correspond to direct properties in the config)
    const topLevelClassNames = Object.keys(properties).map(key => toPascalCase(key));

    for (const classInfo of allClasses) {
        const isTopLevel = topLevelClassNames.includes(classInfo.className);

        dartCode += `final class ${classInfo.className}Keys {\n`;
        dartCode += `  const ${classInfo.className}Keys();\n\n`;
        dartCode += generateStaticProperties(classInfo.properties, classInfo.prefix, '  ', allClasses, isTopLevel);
        dartCode += `}\n\n`;
    }

    // Generate singleton instances for easy access to nested classes only
    for (const classInfo of allClasses) {
        const isTopLevel = topLevelClassNames.includes(classInfo.className);
        if (!isTopLevel) {
            const instanceName = classInfo.className.charAt(0).toLowerCase() + classInfo.className.slice(1);
            dartCode += `const ${instanceName} = ${classInfo.className}Keys();\n`;
        }
    }

    // Ensure exactly one newline at the end by trimming any extra newlines and adding one
    return dartCode.trimEnd() + '\n';
}

/**
 * Generate static properties for a class
 */
function generateStaticProperties(properties, classPrefix, indent, allClasses = [], isTopLevel = true) {
    let result = '';

    for (const [propName, propValue] of Object.entries(properties)) {
        if (typeof propValue === 'string') {
            // Build the full path dynamically instead of hardcoding
            const fullPath = `${classPrefix}_${propName}`;
            if (isTopLevel) {
                result += `${indent}static const ${propName} = TestKey('${fullPath}');\n`;
            } else {
                result += `${indent}final ${propName} = const TestKey('${fullPath}');\n`;
            }
        } else if (typeof propValue === 'object') {
            // Handle nested objects by referencing the nested class
            const nestedClassName = toPascalCase(propName);
            if (isTopLevel) {
                result += `${indent}static const ${propName} = ${nestedClassName}Keys();\n`;
            } else {
                result += `${indent}final ${propName} = const ${nestedClassName}Keys();\n`;
            }
        }
    }

    return result;
}

/**
 * Collect all classes that need to be generated, including nested ones
 */
function collectAllClasses(properties, parentPrefix = '', result = []) {
    for (const [propertyName, propertyValue] of Object.entries(properties)) {
        if (typeof propertyValue === 'object') {
            const className = toPascalCase(propertyName);
            const prefix = parentPrefix ? `${parentPrefix}_${toCamelCase(propertyName)}` : toCamelCase(propertyName);

            result.push({
                className: className,
                prefix: prefix,
                properties: propertyValue
            });

            // Recursively collect nested classes
            collectAllClasses(propertyValue, prefix, result);
        }
    }

    return result;
}

/**
 * Convert string to PascalCase
 */
function toPascalCase(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

/**
 * Convert string to camelCase
 */
function toCamelCase(str) {
    return str.charAt(0).toLowerCase() + str.slice(1);
}

// Run the script
if (require.main === module) {
    generateKeysFile();
}

module.exports = { generateKeysFile }; 