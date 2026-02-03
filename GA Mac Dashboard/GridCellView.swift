import SwiftUI

struct GridCellView: View {
    @EnvironmentObject var appState: AppState
    let cellData: GridCellData

    @State private var urlText: String = ""
    @State private var isEditingURL: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            if !appState.isFullscreen {
                AddressBar(
                    urlText: $urlText,
                    isEditing: $isEditingURL,
                    onSubmit: handleURLSubmit,
                    onRefresh: handleRefresh
                )
            }

            WebView(
                urlString: cellData.url,
                websiteDataStore: appState.sharedWebsiteDataStore,
                cellId: cellData.id
            )
            .border(Color.gray.opacity(0.3), width: 1)
        }
        .onAppear {
            urlText = cellData.url
        }
    }

    private func handleURLSubmit() {
        var finalURL = urlText.trimmingCharacters(in: .whitespacesAndNewlines)

        if !finalURL.isEmpty && !finalURL.hasPrefix("http://") && !finalURL.hasPrefix("https://") {
            finalURL = "https://" + finalURL
        }

        cellData.saveURL(finalURL)
        NotificationCenter.default.post(
            name: .loadURLInCell,
            object: nil,
            userInfo: ["cellId": cellData.id, "url": finalURL]
        )
        isEditingURL = false
    }

    private func handleRefresh() {
        NotificationCenter.default.post(
            name: .refreshWebView,
            object: nil,
            userInfo: ["cellId": cellData.id]
        )
    }
}

struct AddressBar: View {
    @Binding var urlText: String
    @Binding var isEditing: Bool
    let onSubmit: () -> Void
    let onRefresh: () -> Void

    var body: some View {
        HStack(spacing: 4) {
            Button(action: onRefresh) {
                Image(systemName: "arrow.clockwise")
                    .font(.system(size: 11))
            }
            .buttonStyle(.plain)
            .frame(width: 20, height: 20)
            .help("Refresh")

            TextField("Enter URL", text: $urlText, onEditingChanged: { editing in
                isEditing = editing
            })
            .textFieldStyle(.plain)
            .font(.system(size: 11))
            .onSubmit(onSubmit)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(Color(nsColor: .textBackgroundColor))
            .cornerRadius(4)
        }
        .padding(4)
        .background(Color(nsColor: .controlBackgroundColor))
    }
}

extension Notification.Name {
    static let loadURLInCell = Notification.Name("loadURLInCell")
    static let refreshWebView = Notification.Name("refreshWebView")
}

#Preview {
    GridCellView(cellData: GridCellData(id: 0))
        .environmentObject(AppState.shared)
        .frame(width: 400, height: 300)
}
