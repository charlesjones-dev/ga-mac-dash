import SwiftUI
import WebKit

@main
struct GA_Mac_DashboardApp: App {
    @StateObject private var appState = AppState.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
        .commands {
            CommandGroup(replacing: .newItem) { }
        }

        Settings {
            SettingsView()
                .environmentObject(appState)
        }
    }
}

@MainActor
class AppState: ObservableObject {
    static let shared = AppState()

    @Published var columns: Int {
        didSet {
            UserDefaults.standard.set(columns, forKey: "gridColumns")
            updateGridCells()
        }
    }

    @Published var rows: Int {
        didSet {
            UserDefaults.standard.set(rows, forKey: "gridRows")
            updateGridCells()
        }
    }

    @Published var gridCells: [GridCellData] = []
    @Published var isFullscreen: Bool = false

    let sharedProcessPool = WKProcessPool()
    let sharedWebsiteDataStore = WKWebsiteDataStore.default()

    private init() {
        self.columns = UserDefaults.standard.object(forKey: "gridColumns") as? Int ?? 2
        self.rows = UserDefaults.standard.object(forKey: "gridRows") as? Int ?? 3
        updateGridCells()
    }

    private func updateGridCells() {
        let totalCells = columns * rows
        let currentCount = gridCells.count

        if totalCells > currentCount {
            for index in currentCount..<totalCells {
                gridCells.append(GridCellData(id: index))
            }
        } else if totalCells < currentCount {
            gridCells = Array(gridCells.prefix(totalCells))
        }
    }

    func refreshAll() {
        NotificationCenter.default.post(name: .refreshAllWebViews, object: nil)
    }
}

struct GridCellData: Identifiable, Codable {
    let id: Int
    var url: String

    init(id: Int) {
        self.id = id
        self.url = UserDefaults.standard.string(forKey: "gridCell_\(id)_url") ?? ""
    }

    func saveURL(_ newURL: String) {
        UserDefaults.standard.set(newURL, forKey: "gridCell_\(id)_url")
    }
}

extension Notification.Name {
    static let refreshAllWebViews = Notification.Name("refreshAllWebViews")
}
