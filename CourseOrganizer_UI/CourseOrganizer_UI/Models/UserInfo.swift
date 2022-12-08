//
//  UserInfo.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import Foundation

struct UserInfo: Codable, Identifiable {
    let id = UUID()
    var firstName = ""
    var netid = ""
    var username = ""
    var email = ""
    var password = ""
    var takenCourses: Array<Course> = []
    var interestedCourses: Array<Course> = []
    var requirementsNeeded: Array<Requirement> = []

    func getInterestedCourses() -> Array<Course>{
        //make call to server, parse users interested courses and add to array (also add a buttom with fuction for each interested course to schedule a notification!)
        
        return interestedCourses
    }
    mutating func addInterestedCourse(course: Course){
        //post new course to server
        self.interestedCourses.append(course)
    }
    
    
}
