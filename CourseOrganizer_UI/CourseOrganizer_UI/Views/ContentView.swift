//
//  ContentView.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Welcome!")
            }
            .padding()
                
                HStack {
                    NavigationLink (destination: RequirementsView()){
                        Image("Requirements")
                            .renderingMode(.original)
                            .buttonStyle(DirectingButton())
                        Text("Requirements")
                    }.frame(alignment: .bottom)
    
                    NavigationLink(destination: FindCoursesView()){
                        Image("LookCourses")
                            .renderingMode(.original)
                            .buttonStyle(DirectingButton())
                        Text("FindCourses")
                        }.frame(alignment: .bottom)
                    
                    NavigationLink(destination: InterestedCoursesView()){
                        Image("StarCourses")
                            .renderingMode(.original)
                            .buttonStyle(DirectingButton())
                        Text("InterestedCourses")
                    }.frame(alignment: .bottom)
                    
                    NavigationLink(destination: UserView()){
                        Image("User")
                            .renderingMode(.original)
                            .buttonStyle(UserButton())
                        Text("User")
                    }.frame(alignment: .bottom)
                }
            
        }
    }
}

struct UserButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white)
            .clipShape(Circle())
    }
}

struct DirectingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.red)
            .clipShape(Rectangle())
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
