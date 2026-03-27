//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Louis Vincelli on 2/12/26.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @State private var vm = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .toolbar(.hidden, for: .navigationBar)
            }
            .environment(vm)
        }
    }
}
