//
//  UserView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct UserView: View {
    @StateObject private var userVM = UserViewModel()
    var body: some View {
        VStack{
            Text("User Info")
                .font(.largeTitle)
            TextField("first name", text: $userVM.userInfo.firstName).padding()
            TextField("email", text: $userVM.userInfo.email).padding()

            Spacer()
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView()
    }
}
