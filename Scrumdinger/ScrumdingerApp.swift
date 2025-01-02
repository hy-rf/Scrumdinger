//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by hyrf on 1/1/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    var body: some Scene {
        WindowGroup {
            TabView {
                ScrumsView(scrums: $store.scrums) {
                    Task {
                        do {
                            try await store.save(scrums: store.scrums)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error,
                                                        guidance: "Try again later.")
                        }
                    }
                }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error,
                                                    guidance: "Try again later.")
                    }
                }
                .sheet(item: $errorWrapper) {
                    NSLog("%@", "Error")
                } content: { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
                .tabItem {
                    Label("Scrums", systemImage: "gauge.with.needle")
                }
                SettingView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }

        }
    }
}
