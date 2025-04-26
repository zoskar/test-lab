#!/bin/bash

# Store the directory where the script is located
SCRIPT_DIR="$(dirname "$0")"
# Navigate to the project root directory (one level up from maestro)
cd "$SCRIPT_DIR/.."

# Get the absolute path of the project root
PROJECT_ROOT="$(pwd)"
echo "Running from project root: $PROJECT_ROOT"

# Build the debug APK
echo "Building debug APK..."
flutter build apk --debug

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "APK built successfully"
  
  # The path to the debug APK
  APK_PATH="$PROJECT_ROOT/build/app/outputs/flutter-apk/app-debug.apk"
  
  # Check if the APK exists
  if [ -f "$APK_PATH" ]; then
    echo "Installing APK on connected device..."
    adb install -r "$APK_PATH"
    
    if [ $? -eq 0 ]; then
      echo "Installation successful!"
    else
      echo "Installation failed. Make sure a device is connected and debuggable."
      exit 1
    fi
  else
    echo "APK not found at $APK_PATH"
    exit 1
  fi
else
  echo "APK build failed"
  exit 1
fi