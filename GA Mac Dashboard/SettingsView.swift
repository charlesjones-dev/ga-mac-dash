import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State private var tempColumns: Int
    @State private var tempRows: Int

    init() {
        let columns = UserDefaults.standard.object(forKey: "gridColumns") as? Int ?? 2
        let rows = UserDefaults.standard.object(forKey: "gridRows") as? Int ?? 3
        _tempColumns = State(initialValue: columns)
        _tempRows = State(initialValue: rows)
    }

    var body: some View {
        Form {
            Section(header: Text("Grid Layout")) {
                HStack {
                    Text("Columns:")
                        .frame(width: 80, alignment: .trailing)

                    Stepper(value: $tempColumns, in: 1...6) {
                        Text("\(tempColumns)")
                            .frame(width: 30)
                    }
                }

                HStack {
                    Text("Rows:")
                        .frame(width: 80, alignment: .trailing)

                    Stepper(value: $tempRows, in: 1...6) {
                        Text("\(tempRows)")
                            .frame(width: 30)
                    }
                }

                HStack {
                    Spacer()
                    Button("Apply") {
                        appState.columns = tempColumns
                        appState.rows = tempRows
                    }
                    .buttonStyle(.borderedProminent)
                }
            }

            Section(header: Text("Information")) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Total grid cells: \(tempColumns * tempRows)")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("Session data is shared across all cells")
                        .font(.caption)
                        .foregroundColor(.secondary)

                    Text("URLs are automatically saved")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Section(header: Text("Keyboard Shortcuts")) {
                VStack(alignment: .leading, spacing: 4) {
                    shortcutRow(key: "⌘R", description: "Refresh All")
                    shortcutRow(key: "⌘⌃F", description: "Toggle Fullscreen")
                    shortcutRow(key: "⌘,", description: "Settings")
                }
                .font(.caption)
            }
        }
        .formStyle(.grouped)
        .frame(width: 400, height: 400)
        .padding()
    }

    private func shortcutRow(key: String, description: String) -> some View {
        HStack {
            Text(key)
                .font(.system(.caption, design: .monospaced))
                .foregroundColor(.secondary)
                .frame(width: 60, alignment: .trailing)
            Text(description)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState.shared)
}
