//
//  LoginView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/23/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    @StateObject var authentication = Authentication()
    @EnvironmentObject var viewRouter: ViewRouter
    var body: some View {
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
                loginVM.login { success in
                    authentication.updateValidation(success: success)
                }
            }
            .foregroundColor(.white)
            .frame(width: 300, height: 50)
            .background(Color.blue)
            .cornerRadius(10)
            .disabled(loginVM.loginDisabled)
            .onTapGesture {
                // change this line when authentication is implemented
                if !authentication.isValidated {
                    viewRouter.currentScreen = .contentView;
                } else {
                    viewRouter.currentScreen = .loginView;
                }
            }
            Spacer()
        }
        .autocapitalization(.none)
        .padding()
        .disabled(loginVM.showProgressView)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(ViewRouter()).environmentObject(Authentication())
    }
}
