//
//  CourseOrganizer_UIApp.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 10/22/22.
//

import SwiftUI

@main
struct CourseOrganizer_UIApp: App {
    @StateObject var authentication = Authentication()
    @StateObject var userVM = UserViewModel()
    @StateObject var notification = NotificationSwitch()
    var body: some Scene {
        WindowGroup {
            if authentication.isValidated {
                ContentView()
                    .environmentObject(authentication).environmentObject(userVM)
                    .environmentObject(notification)
            }else{
                LoginView()
                    .environmentObject(authentication).environmentObject(userVM)
            }
        }
    }
}
