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
                Text("Course Organizer")
                    .font(.largeTitle)
                Spacer()
                VStack{
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Welcome!")
                        .font(.title)
                }.padding(50)
                Spacer()
                HStack (alignment: .bottom){
                    NavigationLink (destination: RequirementsView()){
                        VStack (spacing: 5) {
                            Image("Requirements")
                                .renderingMode(.original)
                                .buttonStyle(DirectingButton())
                            Text("Requirements")
                                .font(Font.footnote)
                        }
                    }.frame(alignment: .bottom)
                    
                    NavigationLink(destination: FindCoursesView()){
                        VStack (spacing: 5) {
                            Image("LookCourses")
                                .renderingMode(.original)
                                .buttonStyle(DirectingButton())
                            Text("Find Courses")
                                .font(Font.footnote)
                        }
                    }.frame(alignment: .bottom)
                
                    NavigationLink(destination: InterestedCoursesView()){
                        VStack (spacing: 5) {
                            Image("StarCourses")
                                .renderingMode(.original)
                                .buttonStyle(DirectingButton())
                            Text("Interested Courses")
                                .font(Font.footnote)
                        }
                    }.frame(alignment: .bottom)
                    
                    NavigationLink(destination: UserView()){
                        VStack (spacing: 5) {
                            Image("User")
                                .renderingMode(.original)
                                .buttonStyle(UserButton())
                            Text("User")
                                .font(Font.footnote)
                        }
                    }.frame(alignment: .bottom)
                }
            
            }.padding(.bottom)
            .padding()
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
