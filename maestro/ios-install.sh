#!/bin/bash

# Store the directory where the script is located
SCRIPT_DIR="$(dirname "$0")"
# Navigate to the project root directory (one level up from maestro)
cd "$SCRIPT_DIR/.."

# Get the absolute path of the project root
PROJECT_ROOT="$(pwd)"
echo "Running from project root: $PROJECT_ROOT"

# Build the iOS app for simulator
echo "Building iOS app for simulator..."
flutter build ios --debug --simulator

# Check if the build was successful
if [ $? -eq 0 ]; then
  echo "iOS build for simulator completed successfully"
  
  # The path to the app bundle
  APP_PATH="$PROJECT_ROOT/build/ios/iphonesimulator/Runner.app"
  
  # Check if the app bundle exists
  if [ -d "$APP_PATH" ]; then
    echo "Build found at $APP_PATH"
    
    # Get the bundle identifier from Info.plist
    BUNDLE_ID=$(defaults read "$APP_PATH/Info" CFBundleIdentifier)
    if [ -z "$BUNDLE_ID" ]; then
      # Fallback if we can't read the bundle ID
      BUNDLE_ID="com.example.testLab"
      echo "Could not determine bundle identifier, using default: $BUNDLE_ID"
    else
      echo "Found bundle identifier: $BUNDLE_ID"
    fi
    
    # Find running simulators first
    echo "Looking for running simulators..."
    RUNNING_SIM=$(xcrun simctl list devices | grep "Booted" | head -1 | awk -F "[()]" '{print $2}')
    
    if [ -n "$RUNNING_SIM" ]; then
      echo "Found running simulator with ID: $RUNNING_SIM"
      echo "Installing app on simulator..."
      
      # Install the app on the running simulator
      xcrun simctl install "$RUNNING_SIM" "$APP_PATH"
      
      if [ $? -eq 0 ]; then
        echo "Installation successful!"
        
        # Launch the app
        echo "Launching app..."
        xcrun simctl launch "$RUNNING_SIM" "$BUNDLE_ID"
        
        if [ $? -eq 0 ]; then
          echo "App launched successfully!"
        else
          echo "Failed to launch app. You can manually launch it on the simulator."
        fi
      else
        echo "Installation failed."
        exit 1
      fi
    else
      echo "No running simulators found."
      echo "Available iOS simulators:"
      xcrun simctl list devices available | grep "iPhone"
      
      echo "Please start a simulator first, then run this script again."
      echo "Or manually install with: xcrun simctl install <simulator_id> $APP_PATH"
    fi
  else
    echo "App bundle not found at $APP_PATH"
    exit 1
  fi
else
  echo "iOS build failed"
  exit 1
fi