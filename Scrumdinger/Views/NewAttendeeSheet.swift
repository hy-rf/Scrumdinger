//
//  NewAttendeeSheet.swift
//  Scrumdinger
//
//  Created by hyrf on 1/2/25.
//

import SwiftUI

struct NewAttendeeSheet: View {
    @State private var newAttendeeName: String = ""
    @State private var phoneNumber: String = ""
    @State private var selectedSource: String = ""
    @StateObject private var contactManager = ContactManager()
    @Binding var name: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    TextField("Phone Number", text: $phoneNumber)
                }
                Spacer()
                Button(action: {
                    name = newAttendeeName
                    dismiss()
                }, label: {
                    Text("Set selected contact")
                    Image(systemName: "person.crop.rectangle.stack")
                })
                .padding([.top, .trailing], 10)
            }
            List(contactManager.contacts) { contact in
                Text("\(contact.givenName) \(contact.familyName)")
                Button(action: {
                    newAttendeeName = "\(contact.givenName) \(contact.familyName)"
                }, label: {
                    Text("Select")
                })
            }
        }
        .onAppear {
            contactManager.fetchContacts()
        }
        .sheet(isPresented: $contactManager.isContactPickerPresented, content: {
            ContactPickerView(isPresented: $contactManager.isContactPickerPresented, contactManager: contactManager)
        })
        .alert(isPresented: $contactManager.showPermissionAlert) {
            Alert(title: Text("Permission Required"), message: Text("Please enable contacts access in settings."), dismissButton: .default(Text("OK")))
        }
    }
}
