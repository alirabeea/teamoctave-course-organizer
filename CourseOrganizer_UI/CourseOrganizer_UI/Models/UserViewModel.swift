//
//  UserViewModel.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import Foundation

class UserViewModel: ObservableObject {
    
    @Published var userInfo = UserInfo()
    @Published var confpass = ""
    
    
    var createUserDisabled: Bool {
        userInfo.firstName.isEmpty || userInfo.email.isEmpty || userInfo.password.isEmpty || userInfo.username.isEmpty || userInfo.netid.isEmpty || (userInfo.password == confpass)
    }
    
}
