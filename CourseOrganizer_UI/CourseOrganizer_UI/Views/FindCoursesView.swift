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
        let number: String
        let name: String
        let department: String
        let credits: Int
        let verbose: String
    }
    
    var body: some View {
        
        VStack{
            Text("Courses")
                .font(.largeTitle)
            List(courses, id: \.id) {c in
                Section(c.verbose) {
                    Text(c.name)
                    Text("Credit: \(c.credits)")
                    Text("Department: \(c.department)")
                }
            }
        }.onAppear(perform: self.loadCourseInfo)
        Text("\(self.courses.count > 0 ? "" : "")").hidden()
    }
    
    func loadCourseInfo() {
        struct Message: Decodable {
            let courses: [CourseInfo]
            let csrf_token: String
        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/courses/all/") else {
            print("api is down")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("im here")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response: Message = try? JSONDecoder().decode(Message.self, from: data) {
                    DispatchQueue.main.async {
                        self.courses = response.courses;
                        print(response.courses)
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
