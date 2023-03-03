//
// Created for FocusStateRevisited
// by Stewart Lynch on 2022-05-08
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

// Film: https://www.youtube.com/watch?v=VEHn4WanW5g&ab_channel=StewartLynch

struct ContactsListView: View {
    @EnvironmentObject var store: Store
    @State private var formType: FormType?
    var body: some View {
        NavigationView {
            List {
                ForEach(store.contacts) { contact in
                    HStack(alignment: .center) {
                        Image(systemName: "person.fill")
                            .font(.largeTitle)
                            .foregroundColor(.accentColor)
                        VStack(alignment: .leading) {
                            Text("\(contact.firstName) \(contact.lastName)")
                                .font(.title)
                            Text("\(contact.email)")
                        }
                        Spacer()
                        Button {
                            formType = .update(contact)
                        } label: {
                            Text("Edit")
                        }
                        .buttonStyle(.bordered)
                    }
                }
                .onDelete(perform: store.delete)
            }
            .navigationTitle("Contacts")
            .listStyle(.plain)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        formType = .new
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(item: $formType) { $0 }
        }
        .navigationViewStyle(.stack)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsListView()
            .environmentObject(Store(preview: true))
    }
}
