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
    @State private var singleSelection: UUID?
    var body: some View {
        NavigationView{
            VStack {
                Text("Requirements")
                    .font(.largeTitle)
                List(requirementViewModel.requirements, id: \.self) { item in
                    Text(item.name);
                }
                            
                NavigationLink(destination: AddRequirementsView(requirementViewModel: requirementViewModel, courseInfo: requirementViewModel.loadCourseInfo()!)){
                    Text("Add requirement")
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).navigationBarTitle("").navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct RequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsView()
    }
}
