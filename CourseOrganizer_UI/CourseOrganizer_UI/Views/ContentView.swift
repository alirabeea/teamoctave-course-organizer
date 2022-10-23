//
//  ContentView.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Welcome!")
        }
        .padding()
        
        Button (action:{
            print("Directing to Requirements")
        }) {
            Image("Requirements")
                .renderingMode(.original)
                .buttonStyle(DirectingButton())
        }.frame(alignment: .bottom)
        
        Button (action:{
            print("Directing to Find Courses")
        }) {
            Image("LookCourses")
                .renderingMode(.original)
                .buttonStyle(DirectingButton())
        }.frame(alignment: .bottom)
        
        Button (action:{
            print("Directing to Interested Course")
        }) {
            Image("StarCourses")
                .renderingMode(.original)
                .buttonStyle(DirectingButton())
        }.frame(alignment: .bottom)
        
        Button (action: {
            print("Directing to UserInfo")
        }) {
            Image("User")
                .renderingMode(.original)
                .buttonStyle(UserButton())
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
