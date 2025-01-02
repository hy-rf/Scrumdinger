//
//  History.swift
//  Scrumdinger
//
//  Created by hyrf on 1/1/25.
//

import Foundation

struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    var transcript: String?

    var attendeeString: String

    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee], transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.transcript = transcript
        self.attendeeString = attendees.map{ $0.name }.joined(separator: ", ")
    }
}
