//
//  Course.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/30/22.
//

import Foundation

struct Course: Codable, Identifiable, Hashable{
    let id: UUID = UUID()
    var course__id: Int
    var course__verbose: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Course, rhs: Course) -> Bool {
            return lhs.course__id == rhs.course__id

    }
}
