//
//  Course.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/30/22.
//

import Foundation

struct Course: Codable, Identifiable, Hashable{
    let id = UUID()
    let name: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Course, rhs: Course) -> Bool {
            return lhs.name == rhs.name

    }
}
