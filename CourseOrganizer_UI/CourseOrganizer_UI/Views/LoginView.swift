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
    @State var message: String = "";
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
                    loginVM.login { success in
                        authentication.updateValidation(success: success)
                    }
                }
                .foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .onTapGesture {
                    loadAccount();
                }
                .disabled(loginVM.loginDisabled)
                
                
                NavigationLink(destination: SignUpView()){
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
                
                
                
                Spacer()
                Text("Message from server:")
                Text(message)
            }
            .autocapitalization(.none)
            .padding()
            .disabled(loginVM.showProgressView)
        }
    }
    
    struct Message: Decodable {
        let data: String;
    }
    
    func loadAccount() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/test/") else {
            print("api is down")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response: Message = try? JSONDecoder().decode(Message.self, from: data) {
                    DispatchQueue.main.async {
                        message = response.data;
                        print(response.data);
                    }
                    return
                }
            }
            
        }.resume()
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
