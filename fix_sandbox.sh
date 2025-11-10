#!/bin/bash

# Fix sandbox permission issues for Flutter iOS builds
set -e

echo "Fixing sandbox permission issues..."

# Remove quarantine attributes
find . -name "*.framework" -exec xattr -d com.apple.quarantine {} \; 2>/dev/null || true
find . -name "*.dylib" -exec xattr -d com.apple.quarantine {} \; 2>/dev/null || true
find . -name "*.a" -exec xattr -d com.apple.quarantine {} \; 2>/dev/null || true

# Clear build caches
rm -rf build/
rm -rf ios/build/
rm -rf ~/.pub-cache/hosted/
flutter clean

# Clear Xcode derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/Runner-*

# Reinstall pods
cd ios
pod deintegrate
pod install --repo-update
cd ..

# Create build directory with proper permissions
mkdir -p build/ios/Debug-iphonesimulator
chmod 755 build/ios/Debug-iphonesimulator

echo "Sandbox fixes applied. Try building again."