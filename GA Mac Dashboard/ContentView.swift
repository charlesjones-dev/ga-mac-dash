import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        VStack(spacing: 0) {
            if !appState.isFullscreen {
                ToolbarView()
            }

            GridView()
        }
        .frame(minWidth: 800, minHeight: 600)
    }
}

struct ToolbarView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        HStack {
            Text("GA Mac Dashboard")
                .font(.headline)
                .padding(.leading)

            Spacer()

            Button(action: {
                appState.refreshAll()
            }) {
                Image(systemName: "arrow.clockwise")
                Text("Refresh All")
            }
            .keyboardShortcut("r", modifiers: .command)

            Button(action: {
                appState.isFullscreen.toggle()
            }) {
                Image(systemName: appState.isFullscreen ? "arrow.down.right.and.arrow.up.left" : "arrow.up.left.and.arrow.down.right")
                Text(appState.isFullscreen ? "Exit Fullscreen" : "Fullscreen")
            }
            .keyboardShortcut("f", modifiers: [.command, .control])

            Button(action: {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
            }) {
                Image(systemName: "gearshape")
            }
            .help("Settings")

            Spacer()
                .frame(width: 16)
        }
        .padding(.vertical, 8)
        .background(Color(nsColor: .windowBackgroundColor))
    }
}

struct GridView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        GeometryReader { geometry in
            let cellWidth = geometry.size.width / CGFloat(appState.columns)
            let cellHeight = geometry.size.height / CGFloat(appState.rows)

            ZStack {
                ForEach(0..<appState.rows, id: \.self) { row in
                    ForEach(0..<appState.columns, id: \.self) { col in
                        let index = row * appState.columns + col
                        if index < appState.gridCells.count {
                            GridCellView(cellData: appState.gridCells[index])
                                .frame(width: cellWidth, height: cellHeight)
                                .position(
                                    x: CGFloat(col) * cellWidth + cellWidth / 2,
                                    y: CGFloat(row) * cellHeight + cellHeight / 2
                                )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState.shared)
}
