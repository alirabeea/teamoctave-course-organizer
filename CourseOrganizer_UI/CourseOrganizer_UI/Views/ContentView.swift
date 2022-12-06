//
//  ContentView.swift
//  CourseOrganizer_UI
//
//  Created by Kai on 10/22/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            VStack {
                Text("Course Organizer")
                    .font(.largeTitle)
                Spacer()
                VStack{
                    Image("icon1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .foregroundColor(.accentColor)
                    Text("Welcome!")
                        .font(.title)
                }.padding(50)
                Spacer()
            }.tabItem {
                Image(systemName: "house.fill")
                Text("Home").font(Font.footnote)
            }
            InterestedCoursesView().tabItem {
                VStack (spacing: 5) {
                    Image(systemName: "cart.fill")
                    Text("Shopping Cart")
                        .font(Font.footnote)
                }
            }
            RequirementsView().tabItem {
                VStack (spacing: 5) {
                    Image(systemName: "list.bullet.clipboard.fill")
                        .renderingMode(.original)
                        .buttonStyle(DirectingButton())
                    Text("Requirements")
                        .font(Font.footnote)
                }
            }
            FindCoursesView().tabItem{
                VStack {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.original)
                        .buttonStyle(DirectingButton())
                    Text("Find Courses")
                        .font(Font.footnote)
                }
            }
            UserView().tabItem {
                VStack (spacing: 5) {
                    Image(systemName: "person.fill")
                        .renderingMode(.original)
                        .buttonStyle(UserButton())
                    Text("User")
                        .font(Font.footnote)
                }
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
