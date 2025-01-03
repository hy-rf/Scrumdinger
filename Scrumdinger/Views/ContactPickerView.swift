//
//  ContactPickerView.swift
//  Scrumdinger
//
//  Created by hyrf on 1/2/25.
//

import ContactsUI
import SwiftUI

struct ContactPickerView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @ObservedObject var contactManager: ContactManager

    func makeUIViewController(context: Context) -> CNContactPickerViewController {
        let picker = CNContactPickerViewController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: CNContactPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(isPresented: $isPresented, contactManager: contactManager)
    }

    class Coordinator: NSObject, CNContactPickerDelegate {
        @Binding var isPresented: Bool
        var contactManager: ContactManager

        init(isPresented: Binding<Bool>, contactManager: ContactManager) {
            _isPresented = isPresented
            self.contactManager = contactManager
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            contactManager.selectedContact = contact
            contactManager.contacts.append(contact)
            isPresented = false
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            isPresented = false
        }
    }
}
