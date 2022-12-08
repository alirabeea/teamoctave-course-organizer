//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
    @State var requirementViewModel = RequirementsViewModel()
    @State private var singleSelection: Requirement?
    @State var requirementStr : String?
    @State var gradReq = [Requirement]()
    @EnvironmentObject var userVM: UserViewModel
    var body: some View {
        NavigationView{
            VStack {
                Text("Courses")
                    .font(.largeTitle)
                List(gradReq, id: \.self, selection: $singleSelection) { requirement in
                    Section(requirement.description) {
                        ForEach(requirement.courses, id: \.self) { course in
                            Text(course.course__verbose)
                        }
                    }
                }
                .onAppear(perform: self.loadCourseInfo)
                // work around for Swift bug
                Text("\(gradReq.count > 0 ? "no" : "yes")").hidden()
                    
                Button("Add") {
                    if (singleSelection != nil) {
                        requirementViewModel.addRequirement(singleSelection!)
                        self.courseInfoCSRF() { (json) in
                            print(json)
                            let csrf = json.csrf_token
                            postCourseInfo(courses: requirementViewModel.getRequirement(), csrf: csrf, username: userVM.userInfo.username)
                        }
                    }
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).navigationBarTitle("").navigationBarBackButtonHidden(true)
            }
        }
    }
    
    func loadCourseInfo() {
        guard let url = URL(string: "http://127.0.0.1:8000/graduation/requirements/") else {
            print("api is down")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let response: Message = try? JSONDecoder().decode(Message.self, from: data) {
                    DispatchQueue.main.async {
                        self.gradReq = response.requirements;
                        requirementViewModel.setRequirement(response.requirements)
                    }
                    return
                }
            }
        }.resume()
    }
    
    struct Message: Decodable {
        let requirements: [Requirement]
        let csrf_token: String
    }
    
    func courseInfoCSRF(completion: @escaping ((Message) -> Void)){

        guard let url = URL(string: "http://127.0.0.1:8000/users/courses/") else {
            print("api is down")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: url) {
            data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                return
            }
            
            var result: Message?
            //turn the result into a codable Register struct so that we can read the json data
            do{
                result = try JSONDecoder().decode(Message.self, from: data)
                //return the Register struct result in the completion
                completion(result!)
            }catch{
                print("uh oh")
                print(String(describing: error))
            }
            
        }.resume()
    }
    
    func postCourseInfo(courses: [Requirement], csrf: String, username: String) {
        struct Message: Codable {
            var courses: [Int]
            var username: String
        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/users/courses/") else {
            print("api is down")
            return
        }
        var course_id = [Int]()
        for c in courses {
            course_id.append(c.id)
        }
        print(userVM.userInfo.username)
        print(course_id)
        let requirementDataModel = Message(courses: course_id, username: username)
        
        guard let jsonData = try? JSONEncoder().encode(requirementDataModel) else{
            print("could not convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("takenCourses/json", forHTTPHeaderField: "Content-Type")
        request.setValue(csrf, forHTTPHeaderField: "X-CSRFToken")
        request.httpBody = jsonData
        
        URLSession.shared.uploadTask(with: request, from: jsonData, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                print("something went wrong")
                print(String(describing: error))
                return
            }
        }).resume()
    }
}
