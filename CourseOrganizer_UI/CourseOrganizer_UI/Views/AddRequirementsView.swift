//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
    @ObservedObject var requirementViewModel: RequirementsViewModel
    @State private var singleSelection: UUID?
    @State var requirementStr : String?
    let server = Server()
    
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
                Button("Add") {
                    if (requirementStr != nil) {
                        requirementViewModel.addRequirement(requirementStr!)
                        server.registerCSRF(){(json) in
                            let csrf = json.csrf_token
                            server.updateRequirement(requirements: requirementViewModel.requirements, csrf: csrf)
                            print("csrf: " + csrf)
                        }
                    }
                }
            }
            
        }
    }
}

//struct AddRequirementsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRequirementsView(requirements: )
//    }
//}
