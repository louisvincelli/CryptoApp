//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 2/12/26.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
        }
    }
}
