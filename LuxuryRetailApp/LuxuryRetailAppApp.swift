import SwiftUI

@main
struct LuxuryRetailApp: App {
    @StateObject private var cart = CartStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
            }
            .environmentObject(cart)
        }
    }
}
