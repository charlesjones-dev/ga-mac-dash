import SwiftUI
import WebKit

struct WebView: NSViewRepresentable {
    let urlString: String
    let processPool: WKProcessPool
    let websiteDataStore: WKWebsiteDataStore
    let cellId: Int

    func makeNSView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        configuration.processPool = processPool
        configuration.websiteDataStore = websiteDataStore
        configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")

        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true

        context.coordinator.webView = webView

        if let url = URL(string: urlString), !urlString.isEmpty {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(cellId: cellId)
    }

    class Coordinator: NSObject {
        let cellId: Int
        weak var webView: WKWebView?
        private var observers: [NSObjectProtocol] = []

        init(cellId: Int) {
            self.cellId = cellId
            super.init()
            setupObservers()
        }

        deinit {
            observers.forEach { NotificationCenter.default.removeObserver($0) }
        }

        private func setupObservers() {
            let loadURLObserver = NotificationCenter.default.addObserver(
                forName: .loadURLInCell,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                guard let self = self,
                      let userInfo = notification.userInfo,
                      let notificationCellId = userInfo["cellId"] as? Int,
                      notificationCellId == self.cellId,
                      let urlString = userInfo["url"] as? String,
                      let url = URL(string: urlString) else {
                    return
                }
                self.webView?.load(URLRequest(url: url))
            }

            let refreshObserver = NotificationCenter.default.addObserver(
                forName: .refreshWebView,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                guard let self = self,
                      let userInfo = notification.userInfo,
                      let notificationCellId = userInfo["cellId"] as? Int,
                      notificationCellId == self.cellId else {
                    return
                }
                self.webView?.reload()
            }

            let refreshAllObserver = NotificationCenter.default.addObserver(
                forName: .refreshAllWebViews,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                self?.webView?.reload()
            }

            observers = [loadURLObserver, refreshObserver, refreshAllObserver]
        }
    }
}
