//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
    @ObservedObject var requirementViewModel: RequirementsViewModel
    @State var requirementStr : String?
    let server = Server()

    var body: some View {
        
        NavigationView{
            VStack {
                NavigationView {
                    List(requirementViewModel.selection, id: \.self, selection: $requirementStr) {choice in
                        Text(choice)
                    }.navigationTitle("Requirement Selection")
                }
                Button("Add") {
                    requirementViewModel.addRequirement(requirementStr!)
                    server.registerCSRF(){(json) in
                        let csrf = json.csrf_token!
                        server.updateRequirement(requirements: requirementViewModel.requirements, csrf: csrf)
                        print("csrf: " + csrf)
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
