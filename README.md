# GA Mac Dashboard

A native macOS application for viewing multiple Google Analytics real-time dashboards in a customizable grid layout.

![App Icon](GA%20Mac%20Dashboard/Assets.xcassets/AppIcon.appiconset/icon_256x256.png)

## Features

- **Grid Layout**: View multiple Google Analytics dashboards simultaneously in a customizable grid (default 2x3)
- **Shared Sessions**: Login once to Google Analytics, and all grid cells share the same session
- **Minimal UI**: Clean, minimal address bar and refresh button for each cell
- **Fullscreen Mode**: Hide all controls for a distraction-free dashboard view
- **Persistent URLs**: All URLs are automatically saved and restored between sessions
- **Native Performance**: Built with Swift 6.0 and SwiftUI for optimal Apple Silicon performance

## Requirements

- macOS 14.0 or later
- Xcode 15.0 or later (for building from source)
- Apple Silicon (M1/M2/M3) or Intel Mac

## Installation

### Option 1: Build from Source (Recommended)

1. Clone the repository:
   ```bash
   git clone https://github.com/charlesjones-dev/ga-mac-dash.git
   cd ga-mac-dash
   ```

2. Open the project in Xcode:
   ```bash
   open "GA Mac Dashboard.xcodeproj"
   ```

3. Build and run:
   - Select "GA Mac Dashboard" scheme
   - Press ⌘R to build and run
   - Or use Product → Run from menu

4. Install to Applications folder:
   ```bash
   # Build Release version
   xcodebuild -project "GA Mac Dashboard.xcodeproj" \
              -scheme "GA Mac Dashboard" \
              -configuration Release \
              -destination 'platform=macOS,arch=arm64' \
              build CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO

   # Copy to Applications
   cp -R ~/Library/Developer/Xcode/DerivedData/GA_Mac_Dashboard-*/Build/Products/Release/GA\ Mac\ Dashboard.app /Applications/
   ```

### Option 2: Quick Development Build

For development and testing:
```bash
open "GA Mac Dashboard.xcodeproj"
# Press ⌘R in Xcode
```

## Usage

### Adding Dashboard URLs

1. Click on the address bar in any grid cell
2. Paste your Google Analytics dashboard URL
3. Press Enter to load the dashboard

### Keyboard Shortcuts

- `⌘R` - Refresh all dashboards
- `⌘⌃F` - Toggle fullscreen mode
- `⌘,` - Open settings

### Settings

Access settings via the gear icon or press `⌘,` to customize:

- **Grid Layout**: Adjust the number of columns and rows (1-6 each)
- View current grid configuration

### Tips

- Login to Google Analytics in any cell, and all cells will share the session
- URLs are automatically saved and will be restored when you relaunch the app
- Use fullscreen mode for a clean, distraction-free monitoring experience

## Architecture

- **Swift 6.0**: Modern, type-safe Swift with strict concurrency checking
- **SwiftUI**: Declarative UI framework for native macOS experience
- **WKWebView**: Apple's web rendering engine with shared session management
- **UserDefaults**: Persistent storage for URLs and grid configuration

## Building

### Generate App Icons (Optional)

If you modify the icon design:

```bash
# Install Pillow if needed
pip3 install Pillow

# Generate icons
python3 generate_icon.py
```

### Build Configurations

- **Debug**: For development with debugging symbols
- **Release**: Optimized build for production use

### Project Structure

```
ga-mac-dash/
├── GA Mac Dashboard.xcodeproj/     # Xcode project
├── GA Mac Dashboard/
│   ├── GA_Mac_DashboardApp.swift   # App entry point + AppState
│   ├── ContentView.swift           # Main view + toolbar + grid
│   ├── GridCellView.swift          # Individual cell with address bar
│   ├── WebView.swift               # WKWebView wrapper
│   ├── SettingsView.swift          # Grid configuration settings
│   ├── Assets.xcassets/            # App icons and assets
│   └── GA_Mac_Dashboard.entitlements
├── generate_icon.py                # Icon generation script
├── README.md
├── CONTRIBUTING.md
├── CLAUDE.md                       # Development process documentation
└── LICENSE
```

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## Development

This project was built with assistance from Claude AI. See [CLAUDE.md](CLAUDE.md) for details about the development process.

## License

MIT License - see [LICENSE](LICENSE) for details
