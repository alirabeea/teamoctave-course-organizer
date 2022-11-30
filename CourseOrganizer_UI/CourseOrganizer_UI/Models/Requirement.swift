//
//  Requirement.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import Foundation

struct Requirement: Codable, Identifiable, Hashable{
    let id = UUID()
    let name: String
    let numCourses: Int
    var coursesTaken: Array<Course>
    var completed = false
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Requirement, rhs: Requirement) -> Bool {
            return lhs.name == rhs.name

    }
    
}
