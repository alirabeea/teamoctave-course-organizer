//
//  Server.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 11/1/22.
//

import Foundation

class Server {
    var url = "http://127.0.0.1:8000/"
    var registerEndpoint = "register/"
    var coursesEndpoint = "courses/"
    
    // this function is needed to generate a CSRF token that should be sent with the POST
    //call this function and in the closure, call the function that deals with POST requests
    func registerCSRF(completion: @escaping ((Requirements) -> Void)){
        
        guard let url = URL(string: "http://127.0.0.1:8000/users/register/") else {
            print("api is down")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            
            var result: Requirements?
            
            //turn the result into a codable Register struct so that we can read the json data
            do{
                result = try JSONDecoder().decode(Requirements.self, from: data)
                //return the Register struct result in the completion
                completion(result!)
            }catch{
                print(String(describing: error))
            }
            
        }.resume()
        
    }
    
    //same as above, but generates CSRF for a get/post courses request
    func coursesCSRF(endpoint: String, completion: @escaping ((Courses) -> Void)){
        
        guard let url = URL(string: "http://127.0.0.1:8000/" + endpoint) else {
            print("api is down")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            var result: Courses?
            do{
                result = try JSONDecoder().decode(Courses.self, from: data)
                completion(result!)
            }catch{
                print(String(describing: error))
            }
            
        }.resume()
        
    }
    
    //sends all of user data to the server to create a new user
    //currently does not work - server-side issue
    //this function is called when the create account button is pressed - set up the server through terminal to see whether or not the request goes through
    func createAccount(firstName: String, netid: String, email: String, username: String, password: String, csrf: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = URL(string: "http://127.0.0.1:8000/users/register/") else {
            print("api is down")
            return
        }
        //this is a model of the register data that server wants - we give the data we want to send and then it is encoded for sending to server
        let registerDataModel = Register(name: firstName, netid: netid, username: username, password1: password, password2: password, csrfmiddlewaretoken: csrf)
        
        guard let jsonData = try? JSONEncoder().encode(registerDataModel) else{
            print("could not convert model to JSON data")
            return
        }
        
        //create url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //this includes the csrf token in the request header
        request.setValue(csrf, forHTTPHeaderField: "X-CSRFToken")
        
        
        URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else{
                print("something went wrong")
                print(String(describing: error))
                return
            }
            if let response = response as? HTTPURLResponse {
                if(response.statusCode == 200){
                    print("successfully created account!")
                    completion(true)
                }else{
                    print("error creating account. status code: \(response.statusCode)")
                    completion(false)
                }
            }
        }).resume()
    }
    
    func login(email: String, password: String, csrf: String, completion: @escaping ((Bool) -> Void)){
        
        guard let url = URL(string: "http://127.0.0.1:8000/users/login/") else {
            print("api is down")
            return
        }
            
            let loginDataModel = Login(username: email, password: password, csrfmiddlewaretoken: csrf)
            
            guard let jsonData = try? JSONEncoder().encode(loginDataModel) else{
                print("could not convert model to JSON data")
                return
            }
            
            //create url request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: {data, response, error in
                
                guard let data = data, error == nil else{
                    print("something went wrong")
                    print(String(describing: error))
                    return
                }
                if let response = response as? HTTPURLResponse {
                    if(response.statusCode == 200){
                        print("successfully logged in!")
                        completion(true)
                    }else{
                        print("error logging in. status code: \(response.statusCode)")
                        completion(false)
                    }
                }
            }).resume()
            
    }
        
        func loginCSRF(completion: @escaping ((LoginCsrf) -> Void)){
            
            guard let url = URL(string: "http://127.0.0.1:8000/users/login/") else {
                print("api is down")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: url) {
                data, response, error in
                guard let data = data, error == nil else{
                    print("something went wrong")
                    return
                }
                
                
                var result: LoginCsrf?
                
                //turn the result into a codable Register struct so that we can read the json data
                do{
                    result = try JSONDecoder().decode(LoginCsrf.self, from: data)
                    //return the Register struct result in the completion
                    completion(result!)
                }catch{
                    print(String(describing: error))
                }
                
            }.resume()
            
        }
        
        func updateRequirement(requirements: Array<String>, csrf: String) {
            guard let url = URL(string: "http://127.0.0.1:8000/users/register/") else {
                print("api is down")
                return
            }
            let requirementDataModel = Requirements(fields: requirements, csrf_token: csrf)
            
            guard let jsonData = try? JSONEncoder().encode(requirementDataModel) else{
                print("could not convert model to JSON data")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("requirement/json", forHTTPHeaderField: "Content-Type")
            request.setValue(csrf, forHTTPHeaderField: "X-CSRFToken")
            
            //request.httpBody = jsonData
            
            URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: {data, response, error in
                
                guard let data = data, error == nil else{
                    print("something went wrong")
                    print(String(describing: error))
                    return
                }
            }).resume()
        }
        
        
        
        
        
        // get Data from server and decode file into JsonExchange
//        func getData(query: String) async -> Any {
//            guard let server_url = URL(string: url + query) else {
//                print("Invaild URL")
//                return -1
//            }
//
//            var request = URLRequest(url: server_url)
//            request.httpMethod = "GET"
//            print(server_url)
//
//            do {
//                let (data, _) = try await URLSession.shared.data(from: server_url)
//
//                // Need json and their vairable from BackEnd
//                let decodedData = try JSONDecoder().decode(Register.self, from: data)
//                print(decodedData)
//                return decodedData
//
//            } catch {
//                print("ERROR: Unable to complete server request.")
//            }
//            return -1
//        }
        
        func postData(package: Package) async -> Any {
            guard let server_url = URL(string: "") else {
                print("Invaild URL")
                return -1
            }
            
            guard let encoded = try? JSONEncoder().encode(package) else {
                print("Failed to encode")
                return -1
            }
            // This is general POST request. Need to know if backEnd have verification token
            do {
                var request = URLRequest(url: server_url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "POST"
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                return try JSONDecoder().decode(Package.self, from: data)
            } catch {
                print("ERROR: Unable to complete server post")
            }
            
            return -1
        }
    }

