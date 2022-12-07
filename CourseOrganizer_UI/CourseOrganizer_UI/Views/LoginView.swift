//
//  LoginView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/23/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    @EnvironmentObject var userVM: UserViewModel
    @State var message: String = "";
    let server = Server()
    var body: some View {
        NavigationView {
            VStack {
                Text("Course Organizer")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                TextField("Email", text: $loginVM.credentials.email)
                    .padding()
                    .keyboardType(.emailAddress)
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                SecureField("Password", text: $loginVM.credentials.password)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                if loginVM.showProgressView {
                    ProgressView()
                }
                Button("Log In") {
                    server.loginCSRF(){(json) in
                        print(json)
                        let csrf = json.csrf_token
                        print("here is csrf: \(csrf)")
                        server.login(email: loginVM.credentials.email, password: loginVM.credentials.password, csrf: csrf){(isLoggedIn) in
                            if(isLoggedIn){
                                print("logged in success")
                                authentication.updateValidation(success: true)

                            }else{
                                print("unable to create account")
                            }
                        }
                    }
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .disabled(loginVM.loginDisabled)
                
                
                NavigationLink(destination: SignUpView().environmentObject(userVM)){
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
            }
            .autocapitalization(.none)
            .padding()
            .disabled(loginVM.showProgressView)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
