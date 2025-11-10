# Sandbox Permission Fix for iOS Simulator Builds

## The Problem
macOS sandbox restrictions are preventing the Dart compiler from accessing project files during iOS simulator builds, resulting in errors like:
```
Sandbox: dart(xxxxx) deny(1) file-read-data
Sandbox: rsync(xxxxx) deny(1) file-read-data
```

## Solution Options

### Option 1: Grant Full Disk Access to Terminal (Recommended)
1. Open **System Settings** (or System Preferences)
2. Go to **Privacy & Security** → **Full Disk Access**
3. Click the lock icon and authenticate
4. Click the **+** button
5. Navigate to `/Applications/Utilities/` and select **Terminal.app**
6. Enable the checkbox next to Terminal
7. **Restart Terminal completely** (quit and reopen)
8. Try running `flutter run` again

### Option 2: Grant Full Disk Access to VS Code (if running from VS Code)
1. Open **System Settings** (or System Preferences)
2. Go to **Privacy & Security** → **Full Disk Access**
3. Click the lock icon and authenticate
4. Click the **+** button
5. Navigate to `/Applications/` and select **Visual Studio Code.app**
6. Enable the checkbox next to VS Code
7. **Restart VS Code completely**
8. Try running the Flutter app again from VS Code

### Option 3: Use Xcode Directly
1. Open the project in Xcode:
   ```bash
   open ios/Runner.xcworkspace
   ```
2. Select the **iPhone 16 Pro** simulator from the device dropdown
3. Click the **Run** button (▶️) in Xcode
4. Xcode has appropriate permissions and may bypass the sandbox issues

### Option 4: Temporarily Disable SIP (Not Recommended - Security Risk)
Only use this as a last resort:
1. Restart your Mac and hold **Cmd+R** during boot to enter Recovery Mode
2. Open Terminal from Utilities menu
3. Run: `csrutil disable`
4. Restart your Mac
5. Build your app
6. Re-enable SIP by repeating steps 1-2 and running: `csrutil enable`

### Option 5: Build on Physical Device Instead
Build for a physical iOS device which doesn't have the same sandbox restrictions:
```bash
flutter run -d <your-physical-device-id>
```

## Verification
After applying any fix, verify it works:
```bash
cd /Users/chambas/Documents/FlutterProjects/islamic_center_prayer_times
flutter clean
flutter pub get
flutter run -d "iPhone 16 Pro"
```

## Current Environment
- macOS Version: 26.0.1 (Sequoia or later)
- Xcode Version: 26.1
- Flutter Version: 3.35.6
- Issue: Modern macOS security features preventing file system access

## Additional Notes
The sandbox errors are macOS security features working as designed. The Dart compiler needs permission to read source files and write build artifacts. Granting Full Disk Access to your development tools is the standard solution for this issue.
