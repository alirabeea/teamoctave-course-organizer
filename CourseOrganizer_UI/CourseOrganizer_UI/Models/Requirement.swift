//
//  Requirement.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import Foundation

struct Requirement: Codable, Identifiable, Hashable {
    var id : Int
    var description: String
    var number_courses: Int
    var major__name: String
    var courses: [Course]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Requirement, rhs: Requirement) -> Bool {
            return lhs.description == rhs.description

    }
    
}
