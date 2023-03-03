//
//  FormViewModel.swift
//  Forms and Focus
//
//  Created by Marcin Jędrzejak on 02/03/2023.
//

import Foundation

class FormViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    
    var id: String?
    
    var updating: Bool { id != nil }
    
    init() {}
    
    init(_ contact: Contact) {
        firstName = contact.firstName
        lastName = contact.lastName
        email = contact.email
        id = contact.id
    }
    
    var incomplete: Bool {
        firstName.isEmpty || lastName.isEmpty || email.isEmpty
    }
}
