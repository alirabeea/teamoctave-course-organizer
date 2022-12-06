//
//  RequirementsViewModel.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/3/22.
//

import Foundation
import SwiftUI

class RequirementsViewModel: ObservableObject {
    @Published var chosenRequirement : Array<Requirement> = [];
    let server = Server()
    @Published var requirements = [Requirement]()
    
    //determine if requirement is filled or not
    func isCompleted(requirement: Requirement) -> Bool{
        //return requirement.numCourses == requirement.coursesTaken.count
        return false
    }
    
    func loadCourseInfo() {
        struct Message: Decodable {
            let requirements: [Requirement]
        }
        
        //same as above, but generates CSRF for a get/post graduation requirement request
        guard let url = URL(string: "http://127.0.0.1:8000/graduation/requirements/") else {
            print("api is down")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response: Message = try? JSONDecoder().decode(Message.self, from: data) {
                    DispatchQueue.main.async {
                        self.requirements = response.requirements;
                    }
                    return
                }
            }
        }.resume()
    }
    
    func getRequirement() -> [Requirement]{
        self.loadCourseInfo()
        return requirements
    }
    
    func addRequirement(_ requirement: Requirement) {
        self.chosenRequirement.insert(requirement, at: 0);
        print(self.chosenRequirement);
    }
}
