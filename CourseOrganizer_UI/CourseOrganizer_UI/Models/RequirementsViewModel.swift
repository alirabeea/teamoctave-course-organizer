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
    
    
    var selection: Array<Requirement> = [
        Requirement(name: "Introductory Computer Science Courses", numCourses: 2, coursesTaken: [Course(name: "testcourse")]),
        Requirement(name: "Core Computer Science Courses", numCourses: 4, coursesTaken: []),
        Requirement(name: "Mathematics Courses", numCourses: 4, coursesTaken: []),
        Requirement(name: "Upper-Level Elective Computer Science Courses", numCourses: 8, coursesTaken: []),
        Requirement(name: "Lab Science Courses", numCourses: 2, coursesTaken: []),
        Requirement(name: "Junior Year Writing Requirement", numCourses: 1, coursesTaken: []),
        Requirement(name: "Integrative Experience Requirement", numCourses: 1, coursesTaken: [])
    ]
    
    //determine if requirement is filled or not
    func isCompleted(requirement: Requirement) -> Bool{
        return requirement.numCourses == requirement.coursesTaken.count
    }
    
    func addRequirement(_ requirement: String) {
        self.requirements.insert(requirement, at: 0);
        print(self.requirements);
    }
}
