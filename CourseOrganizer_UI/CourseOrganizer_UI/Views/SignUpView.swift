//
//  SignUpView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct SignUpView: View {
    let server = Server()
    @StateObject private var userVM = UserViewModel()
    @State var message: String = "";
    var body: some View {
        VStack{
           
            Text("Sign Up")
                .font(.largeTitle)
                
            TextField("first name", text: $userVM.userInfo.firstName)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            TextField("net id", text: $userVM.userInfo.netid)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
            TextField("username", text: $userVM.userInfo.username)
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
            Button("Create account"){ //this is where create account is called
                //first, get the csrf token to be plugged into the createAccount function
                
                server.registerCSRF(endpoint: "register/"){(json) in
                    let csrf = json.csrf_token!
                    server.createAccount(firstName: userVM.userInfo.firstName, netid: userVM.userInfo.netid, email: userVM.userInfo.email, username: userVM.userInfo.username, password: userVM.userInfo.password, csrf: csrf)
                    print("csrf: " + csrf)
                }
            

            }.foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                //.disabled(userVM.createUserDisabled)
 
        }.autocapitalization(.none)
        
        Spacer()
    }

    var session = URLSession.shared


    struct Message: Codable{
        let data: String
    }
        
    
    
   
}
    



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
