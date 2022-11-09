//
//  JsonExchange.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 11/3/22.
//

import Foundation

// JSON structure from backend
struct Package: Decodable, Encodable {
    
}

//this is the structure for sending or recieving /register json
struct Register: Codable {
//    let fields: Array<String>?
//    let csrf_token: String?
    let name: String?
    let netid: String?
    let username: String?
    let password1: String?
    let password2: String?
    let csrfmidlewaretoken: String?
}
   

struct Courses: Decodable, Encodable {
    
}
// struct for sending and receiving reuirement
struct Requirements: Decodable, Encodable {
    let fields: Array<String>
    let csrf_token: String
}

//this is the json format for a register post or get
/*
{"fields": ["name", "netid", "username", "password1", "password2"], "csrf_token": "N1dVGCzTtWk8O0cYTbmEsquQhfDk8NsHlVjTGZRzkr51GA0Mb3REfFQlcotR63qI"}

*/

