//
//  InterestedCoursesView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct InterestedCoursesView: View {
    @State private var newCourse = ""
    @State var user = UserInfo()
    //hard coded until we can pull from server
    private var courseOne = "CS 311"
    private var courseTwo = "CS 325"
    var body: some View {
        ZStack{
            
            VStack{
                
                    
                Text("Interested Courses")
                    .font(.largeTitle)
                    .onAppear(){
                        user.getInterestedCourses()
                    }.padding()
                Divider()
                    .padding()
                VStack(){
                    Text(courseOne)
                    Text(courseTwo)
                }.font(.title)
                
                Spacer()
                HStack(alignment: .bottom){
                    VStack{
                        Text("Add a course").font(.headline)
                        TextField("Enter course name", text: $newCourse)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.05))
                            .cornerRadius(10)
                            .onSubmit{
                                user.addInterestedCourse(course: newCourse)
                            }
                    }
                }
                
                
                
            }
            
        }

    }

}


struct InterestedCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedCoursesView()
    }
}
