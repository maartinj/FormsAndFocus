//
// Created for Forms and Focus
// by Stewart Lynch on 2022-05-08
// Using Swift 5.0
//
// Follow me on Twitter: @StewartLynch
// Subscribe on YouTube: https://youTube.com/StewartLynch
//

import SwiftUI

@main
struct AppEntry: App {
    @StateObject var store = Store()
    var body: some Scene {
        WindowGroup {
            ContactsListView()
                .environmentObject(store)
        }
    }
}
