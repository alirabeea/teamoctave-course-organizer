//
//  Server.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 11/1/22.
//

import Foundation

class server {
    var url = "http://127.0.0.1:8000"
    
    func doGetData(query: String){
        Task {
            await getData(query: query)
        }
    }
    
    // get Data from server and decode file into JsonExchange
    func getData(query: String) async -> Any {
        guard let server_url = URL(string: url + query) else {
            print("Invaild URL")
            return -1
        }
        
        var request = URLRequest(url: server_url)
        request.httpMethod = "GET"
        print(server_url)
        
        do {
            let (data, _) = try await URLSession.shared.data(from: server_url)
            
            // Need json and their vairable from BackEnd
            let decodedData = try JSONDecoder().decode(Register.self, from: data)
            print(decodedData)
            return decodedData
            
        } catch {
            print("ERROR: Unable to complete server request.")
        }
        return -1
    }
    
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
