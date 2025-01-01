//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by hyrf on 1/1/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
