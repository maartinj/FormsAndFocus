//
//  FormView.swift
//  Forms and Focus
//
//  Created by Marcin Jędrzejak on 02/03/2023.
//

import SwiftUI

struct FormView: View {
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: FormViewModel
    @FocusState private var focus: AnyKeyPath?
    var body: some View {
        NavigationView {
            Form {
                TextField("First Name", text: $viewModel.firstName, onCommit: nextFocus)
                    .focused($focus, equals: \FormViewModel.firstName)
                TextField("Last Name", text: $viewModel.lastName, onCommit: nextFocus)
                    .focused($focus, equals: \FormViewModel.lastName)
                TextField("Email Address", text: $viewModel.email, onCommit: nextFocus)
                    .focused($focus, equals: \FormViewModel.email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
            }
            .navigationTitle("Contact")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.updating ? "Update" : "Add") {
                        viewModel.updating ? updateContact() : createContact()
                    }
                    .disabled(viewModel.incomplete)
                }
                ToolbarItem(placement: .keyboard) {
                    HStack {
//                        Spacer()
                        Button {
                            focus = nil
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
        }
        .task {
            if !viewModel.updating {
                try? await Task.sleep(nanoseconds: 500_000)
                focus = \FormViewModel.firstName
            }
        }
    }
    
    func nextFocus() {
        switch focus {
        case \FormViewModel.firstName:
            focus = \FormViewModel.lastName
        case \FormViewModel.lastName:
            focus = \FormViewModel.email
        case \FormViewModel.email:
            focus = \FormViewModel.firstName
        default:
            break
        }
    }
    
    func updateContact() {
        let contact = Contact(id: viewModel.id!,
                              firstName: viewModel.firstName,
                              lastName: viewModel.lastName,
                              email: viewModel.email)
        store.update(contact)
        dismiss()
    }
    
    func createContact() {
        let contact = Contact(firstName: viewModel.firstName,
                              lastName: viewModel.lastName,
                              email: viewModel.email)
        store.create(contact)
        dismiss()
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(viewModel: FormViewModel())
            .environmentObject(Store())
    }
}
