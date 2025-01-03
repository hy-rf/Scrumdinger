//
//  ContactsManager.swift
//  Scrumdinger
//
//  Created by hyrf on 1/2/25.
//

import Foundation
import ContactsUI

class ContactManager: ObservableObject {
    @Published var isContactPickerPresented: Bool = false
    @Published var showPermissionAlert: Bool = false
    @Published var limitedAccess: Bool = false
    @Published var contacts: [CNContact] = []
    @Published var selectedContact: CNContact?

    private let contactStore = CNContactStore()

    func checkContactPermission() {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
            case .notDetermined:
                CNContactStore().requestAccess(for: .contacts) { granted, error in
                    if granted {
                        DispatchQueue.main.async {
                            self.isContactPickerPresented = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showPermissionAlert = true
                        }
                    }
                }
            case .authorized:
                self.isContactPickerPresented = true
            case .denied, .restricted:
                self.showPermissionAlert = true
            case .limited:
                self.limitedAccess = true
            @unknown default:
                break
        }
    }

    func fetchContacts() {
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keysToFetch as [CNKeyDescriptor])

        DispatchQueue.global(qos: .userInitiated).async {
            do {
                try self.contactStore.enumerateContacts(with: request) { (contact, _) in
                    DispatchQueue.main.async {
                        print("get contact")
                        self.contacts.append(contact)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error fetching contacts: \(error)")
                }
            }
        }
    }
}
