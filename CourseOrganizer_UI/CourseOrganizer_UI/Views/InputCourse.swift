//
//  InputCourse.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 10/24/22.
//

import SwiftUI

struct InputCourse: View {
    @State private var textinput: String = "";
    @EnvironmentObject var viewRouter: ViewRouter;

    var body: some View {
        NavigationView{
            VStack {
                Text("Add taken course")
                    .font(.largeTitle)
                    .bold()
                    .padding();
                List{
                    Text("Course Name");
                    TextField("Enter Course name", text: $textinput);
                }
                Button("Add another course") {
                    print("Add course");
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10)
            }
        }.navigationTitle("Input Course").navigationBarTitleDisplayMode(.inline)
    }
}

struct InputCourse_Previews: PreviewProvider {
    static var previews: some View {
        InputCourse()
    }
}
