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
    
    @Published var requirements : Array<String> = [];
    
    var selection: Array<Requirement> = [Requirement(name: "Introductory Computer Science Courses", numCourses: 2, coursesTaken: []),Requirement(name: "Core Computer Science Courses", numCourses: 4, coursesTaken: []), Requirement(name: "Mathematics Courses", numCourses: 4, coursesTaken: []),Requirement(name: "Upper-Level Elective Computer Science Courses", numCourses: 8, coursesTaken: []),Requirement(name: "Lab Science Courses", numCourses: 2, coursesTaken: []),Requirement(name: "Junior Year Writing Requirement", numCourses: 1, coursesTaken: []), Requirement(name: "Integrative Experience Requirement", numCourses: 1, coursesTaken: []) ]

    struct Requirement: Codable, Identifiable, Hashable{
        let id = UUID()
        let name: String
        let numCourses: Int
        var coursesTaken: Array<Course>

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        static func == (lhs: Requirement, rhs: Requirement) -> Bool {
                return lhs.name == rhs.name

        }
        
    }
    struct Course: Codable, Identifiable, Hashable{
        let id = UUID()
        let name: String
        let coversRequirement: Requirement
   
        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        static func == (lhs: Course, rhs: Course) -> Bool {
                return lhs.name == rhs.name

        }
    }
    
    func addRequirement(_ requirement: String) {
        self.requirements.insert(requirement, at: 0);
        print(self.requirements);
    }
}
