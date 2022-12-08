//
//  RequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI
// Show requirements the user has to fulfill
struct RequirementsView: View {
    @ObservedObject var requirementViewModel = RequirementsViewModel()
    @EnvironmentObject var userVM: UserViewModel
    //@State private var singleSelection: UUID?
    var body: some View {
        NavigationView{
            VStack {
                Text("Taken Courses")
                    .font(.largeTitle)
                
                List(requirementViewModel.chosenRequirement, id: \.self) { item in
                    Section(item.description) {
                        ForEach(item.courses,  id: \.self) { course in
                            Text("\(course.course__verbose)")
                        }
                    }
                }

                NavigationLink(destination: AddRequirementsView(requirementViewModel: requirementViewModel)){
                    Text("Add courses")
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).navigationBarTitle("").navigationBarBackButtonHidden(true)
                
            }
        }
    }
}

struct RequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsView().environmentObject(UserViewModel())
    }
}
