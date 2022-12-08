//
//  FindCoursesView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct FindCoursesView: View {
    @State var courses = [CourseInfo]()
    struct CourseInfo: Codable {
        let id: Int
        let number: Int
        let name: String
        let departmant: String
        let credit: Int
    }
    var body: some View {
        VStack{
//            ForEach(courses) {c in
//                Text(c.course__verbose)
//            }
        }
    }
    
    func loadCourseInfo() {
        struct Message: Decodable {
            let courses: [CourseInfo]
        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/courses/all/") else {
            print("api is down")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response: Message = try? JSONDecoder().decode(Message.self, from: data) {
                    DispatchQueue.main.async {
                        self.courses = response.courses;
                    }
                    return
                }
            }
        }.resume()
    }
}

struct FindCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        FindCoursesView()
    }
}
