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
    var takenCourses: Array<String> = []
    var interestedCourses: Array<String> = []
    

    func getInterestedCourses(){
        //make call to server, parse users interested courses and add to array
    }
    func addInterestedCourse(course: String){
        //post new course to server
    }
    func getRequirements(){
        //get requirements from server, parse and store
    }
    
}
