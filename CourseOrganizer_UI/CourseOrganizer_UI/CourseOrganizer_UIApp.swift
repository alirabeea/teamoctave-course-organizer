//
//  CourseOrganizer_UIApp.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 10/22/22.
//

import SwiftUI

@main
struct CourseOrganizer_UIApp: App {
    @EnvironmentObject var authentication: Authentication
    var body: some Scene {
        WindowGroup {
// moved to login view login button
//            if authentication.isValidated {
//                ContentView()
//                    .environmentObject(authentication)
//            }else{
//                LoginView()
//                    .environmentObject(authentication)
//            }
            MainView();
        }
    }
}
