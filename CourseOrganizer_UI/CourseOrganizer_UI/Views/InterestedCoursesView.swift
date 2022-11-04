//
//  InterestedCoursesView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct InterestedCoursesView: View {
    @State private var newCourse = ""
    var body: some View {
        VStack{
            Text("Interested Courses")
                .font(.largeTitle)
            Spacer()
            
            Text("Add a course")
            TextField("Enter course name", text: $newCourse)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .onSubmit{
                    addInterestedCourse(course: newCourse)
                }
            
            Spacer()
            
            
        }
    }
}
func addInterestedCourse(course: String){
    
}

func getInterestedCourses(){
    
}

struct InterestedCoursesView_Previews: PreviewProvider {
    static var previews: some View {
        InterestedCoursesView()
    }
}
