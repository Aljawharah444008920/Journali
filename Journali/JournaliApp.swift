//
//  JournaliApp.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 29/05/1448 AH.
//

import SwiftUI
import SwiftData

@main
struct JournaliApp: App {

    @State private var showHome = false

    var body: some Scene {
        WindowGroup {
            Group {
                if showHome {
                    EmptyStateView()
                } else {
                    ContentView()
                }
            }
            .task {
                try? await Task.sleep(for: .seconds(5))
                showHome = true
            }
        }
        .modelContainer(for: Journal.self)
    }
}
