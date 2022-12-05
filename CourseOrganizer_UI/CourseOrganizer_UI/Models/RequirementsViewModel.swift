//
//  RequirementsViewModel.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/3/22.
//

import Foundation
import SwiftUI

class RequirementsViewModel: ObservableObject {
//    struct Req: Identifiable, Hashable {
//        let name: String
//        let id = UUID()
//    }
    
    @Published var requirements : Array<Course> = [];
    
 
//    var selection: Array<Requirement> = [
//        Requirement(name: "Introductory Computer Science Courses", numCourses: 2, coursesTaken: [Course(name: "CS121"), Course(name: "CS187")]),
//        Requirement(name: "Core Computer Science Courses", numCourses: 4, coursesTaken: [Course(name: "CS220"), Course(name: "CS230"), Course(name: "CS240"),Course(name: "CS250")]),
//        Requirement(name: "Mathematics Courses", numCourses: 4, coursesTaken: []),
//        Requirement(name: "Upper-Level Elective Computer Science Courses", numCourses: 8, coursesTaken: []),
//        Requirement(name: "Lab Science Courses", numCourses: 2, coursesTaken: []),
//        Requirement(name: "Junior Year Writing Requirement", numCourses: 1, coursesTaken: []),
//        Requirement(name: "Integrative Experience Requirement", numCourses: 1, coursesTaken: [])
//    ]
    
    //determine if requirement is filled or not
    func isCompleted(requirement: Requirement) -> Bool{
        //return requirement.numCourses == requirement.coursesTaken.count
        return false
    }
    
    func loadCourseInfo() -> [Requirement]?  {
        if let url = Bundle.main.url(forResource: "Graduation Requirements", withExtension: "json") {
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let req = try decoder.decode([Requirement].self, from: jsonData)
                return req
            } catch {
                print(error)
                print("not ok")
            }
        }
        return []
    }
    
    func addRequirement(_ requirement: Course) {
        self.requirements.insert(requirement, at: 0);
        print(self.requirements);
    }
}
