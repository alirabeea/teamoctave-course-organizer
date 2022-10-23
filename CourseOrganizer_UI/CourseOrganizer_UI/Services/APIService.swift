//
//  APIService.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/23/22.
//

import Foundation

class APIService {
    static let shared = APIService()
    enum APIError: Error {
        case error
    }
    
    func login(credentials: Credentials, completion: @escaping (Result<Bool, APIError>) -> Void) {
        //replace with call to actual credentials
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            if credentials.password == "password" {
                completion(.success(true))
            }else {
                completion(.failure(APIError.error))
            }
        }
    }
}
