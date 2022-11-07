//
//  SignUpView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct SignUpView: View {
    
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
                let csrf = getCSRF()
                createAccount(firstName: userVM.userInfo.firstName, netid: userVM.userInfo.netid, email: userVM.userInfo.email, username: userVM.userInfo.username, password: userVM.userInfo.password, csrf: csrf)

            }.foregroundColor(.white)
                .frame(width: 300, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
                //.disabled(userVM.createUserDisabled)
 
        }.autocapitalization(.none)
        
        Spacer()
    }

    var session = URLSession.shared

    
    
    // this function is needed to generate a CSRF token that should be sent with the POST
    //returns token as a string
    func getCSRF() -> String{
        var csrf_token = ""
        guard let url = URL(string: "http://127.0.0.1:8000/users/register/") else {
                print("api is down")
                return "none"
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: URL(string: "http://127.0.0.1:8000/users/register/")!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            var result: Register?
            do{
                result = try JSONDecoder().decode(Register.self, from: data)
            }catch{
                print(String(describing: error))
            }
            guard let json = result else{
                return
            }
            csrf_token =  String(json.csrf_token!)
            print (csrf_token)
        }).resume()
        
        return csrf_token
    }
    struct Message: Codable{
        let data: String
    }
        
    
    //sends all of user data to the server to create a new user
    //currently does not work - server is unable to read the CSRF token
    //this function is called when the create account button is pressed - set up the server through terminal to see whether or not the request goes through
    func createAccount(firstName: String, netid: String, email: String, username: String, password: String, csrf: String) {
        guard let url = URL(string: "http://127.0.0.1:8000/users/register/") else {
            print("api is down")
            return
        }
        let registerDataModel = Register(fields: [firstName, netid, username, password, password], csrf_token: csrf)
        
        guard let jsonData = try? JSONEncoder().encode(registerDataModel) else{
            print("could not convert model to JSON data")
            return
        }
        
        //create url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(csrf, forHTTPHeaderField: "csrf_token")
        
        //request.httpBody = jsonData
        
        URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else{
                print("something went wrong")
                print(String(describing: error))
                return
            }
        }).resume()
        

        
    }
   
}
    



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
