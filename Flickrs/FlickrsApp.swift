//
//  FlickrsApp.swift
//  Flickrs
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

@main
struct FlickrsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)

        }
    }
}
