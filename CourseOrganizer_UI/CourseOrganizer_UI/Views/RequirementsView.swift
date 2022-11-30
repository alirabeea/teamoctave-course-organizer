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
//                List(selection: $singleSelection) {
//                    ForEach(requirementViewModel.selection) { requirement in
//                        Section(header: Text("\(requirement.name)")) {
//                            ForEach(requirement.coursesTaken) { course in
//                                Text("\(course.name)")
//                            }
//                        }
//                    }
//                }
                List(requirementViewModel.requirements, id: \.self) { item in
                    Text(item);
                }
                            
                NavigationLink(destination: AddRequirementsView(requirementViewModel: requirementViewModel)){
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
