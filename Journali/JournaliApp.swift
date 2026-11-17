//
//  JournaliApp.swift
//  Journali
//
//  Created by Aljawharah Alotaibi on 29/05/1448 AH.
//
// مكان تشغيل الاب 
import SwiftUI
import SwiftData

@main
struct JournaliApp: App {

    @State private var showHome = false //افتراضيا يكون الهوم غير ظاهر

    var body: some Scene {
        WindowGroup {
            Group {
                if showHome {
                    EmptyStateView()
                } else {
                    ContentView()
                }
            }
            .task {//مهمه تتعلق بالواجهه
                try? await Task.sleep(for: .seconds(2))
                showHome = true
            }
        }
        .modelContainer(for: Journal.self)//هنا تم تجهيزحاوية SwiftData الخاصة باليوميات، حتى نقدر نحفظها ونسترجعها.
    }
}
