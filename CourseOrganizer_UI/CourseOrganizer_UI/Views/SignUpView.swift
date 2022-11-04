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
            Button("Create account"){
                createAccount()
            }.foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .disabled(userVM.createUserDisabled)
        }.autocapitalization(.none)
        
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
        @EnvironmentObject var userVM: UserViewModel
        guard let url = URL(string: "http://127.0.0.1:8000/users/register/") else {
            print("api is down")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let json = [
            "firstname": userVM.userInfo.firstName,
            "netid": userVM.userInfo.netid,
            "username": userVM.userInfo.username,
            "password1": userVM.userInfo.password,
            "password2": userVM.userInfo.password]

        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response: Message = try? JSONDecoder().decode(Message.self, from: data) {
                    DispatchQueue.main.async {
                        
                            do {                                    request.httpBody = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) // pass dictionary to data object and set it as request body
                                } catch let error {
                                    print(error.localizedDescription)
                                }
            
                        print(response.data);
                    }
                    return
                }
            }
            
        }.resume()
    }


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
