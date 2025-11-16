//
//  LuxuryRetailAppApp.swift
//  LuxuryRetailApp
//
//  Created by user279259 on 12/11/2025.
//

import SwiftUI

@main
struct LuxuryRetailApp: App {
    @State private var cart = CartStore()

    init() {
        let whiteNav = UINavigationBarAppearance()
        whiteNav.configureWithTransparentBackground()
        whiteNav.titleTextAttributes = [.foregroundColor: UIColor.white]
        whiteNav.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = whiteNav
        UINavigationBar.appearance().scrollEdgeAppearance = whiteNav
        UINavigationBar.appearance().compactAppearance = whiteNav
        UINavigationBar.appearance().tintColor = .white
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}

