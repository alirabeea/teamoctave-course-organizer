//
//  SignUpView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var userVM = UserViewModel()
    var body: some View {
        VStack{
            Text("Sign Up")
                .font(.largeTitle)
            TextField("first name", text: $userVM.userInfo.firstName)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            TextField("email", text: $userVM.userInfo.email)
                .padding()
                .keyboardType(.emailAddress)
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            SecureField("password", text: $userVM.userInfo.password)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            Button("Create account"){
                
            }.foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .onTapGesture {
                    createAccount()
                }.disabled(userVM.createUserDisabled)
            
            Spacer()
        }
    }
    struct Message: Decodable {
        let data: String;
    }
    
    
    //connect to backend, add new user with info
    //entered user info is stored in userVM.userInfo
    //as .firstName, .email, .password
    func createAccount() {
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
