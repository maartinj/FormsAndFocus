//
//  FormType.swift
//  Forms and Focus
//
//  Created by Marcin Jędrzejak on 03/03/2023.
//

import SwiftUI

enum FormType: Identifiable, View {
    case new
    case update(Contact)
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return FormView(viewModel: FormViewModel())
        case .update(let contact):
            return FormView(viewModel: FormViewModel(contact))
        }
    }
}
