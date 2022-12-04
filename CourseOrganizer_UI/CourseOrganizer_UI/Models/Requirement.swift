//
//  Requirement.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import Foundation

struct Requirement: Codable, Identifiable, Hashable{
    var id : UUID
//    let name: String
//    let numCourses: Int
//    var coursesTaken: Array<Course>
//    var completed = false
    //var allCourseSatisfy: Array<Course>
    var major: String
    var graduation_requirement: String
    var course_quantity: Int
    var courses_satisfying: [String]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Requirement, rhs: Requirement) -> Bool {
            return lhs.graduation_requirement == rhs.graduation_requirement

    }
    
}
