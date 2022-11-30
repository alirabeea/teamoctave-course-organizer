//
//  RequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct RequirementsView: View {
    @ObservedObject var requirementViewModel = RequirementsViewModel()
    @State private var singleSelection: UUID?
    var body: some View {
        NavigationView{
            VStack {
                Text("Requirements")
                    .font(.largeTitle)
                List(selection: $singleSelection) {
                    ForEach(requirementViewModel.selection) { requirement in
                                    Section(header: Text("\(requirement.name)")) {
                                        ForEach(requirement.coursesTaken) { course in
                                            Text("\(course.name)")
                                        }
                                    }
                                }
                            }
                            
                NavigationLink(destination: AddRequirementsView(requirementViewModel: requirementViewModel)){
                    Text("Add requirement")
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).navigationBarTitle("").navigationBarBackButtonHidden(true)
            }
            NavigationLink(destination: AddRequirementsView(requirementViewModel: requirementViewModel)){
                Text("Add requirement")
            }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).navigationBarTitle("")
        }
    }
}

struct RequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsView()
    }
}
