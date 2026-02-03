# GA Mac Dashboard

A native macOS application for viewing multiple Google Analytics real-time dashboards in a customizable grid layout.

## Features

- **Grid Layout**: View multiple Google Analytics dashboards simultaneously in a customizable grid (default 2x3)
- **Shared Sessions**: Login once to Google Analytics, and all grid cells share the same session
- **Minimal UI**: Clean, minimal address bar and refresh button for each cell
- **Fullscreen Mode**: Hide all controls for a distraction-free dashboard view
- **Persistent URLs**: All URLs are automatically saved and restored between sessions
- **Native Performance**: Built with Swift 6.0 and SwiftUI for optimal Apple Silicon performance

## Requirements

- macOS 14.0 or later
- Apple Silicon (M1/M2/M3) or Intel Mac

## Installation

1. Open `GA Mac Dashboard.xcodeproj` in Xcode
2. Select your target device
3. Click Run or press ⌘R

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
- **WKWebView**: Apple's web rendering engine with shared process pool
- **UserDefaults**: Persistent storage for URLs and grid configuration

## License

MIT License
