//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
    @ObservedObject var requirementViewModel: RequirementsViewModel
    @State private var singleSelection: Requirement?
    @State var requirementStr : String?
    let server = Server()
    let courseInfo: [Requirement]
    var body: some View {
        NavigationView{
            VStack {
                Text("Requirements")
                    .font(.largeTitle)
                //List(selection: $singleSelection) {
                
//                List(requirementViewModel.selection, selection: $singleSelection) { requirement in
//                        //print($singleSelection)
//                    Section(".\(requirement.name)") {
//                        ForEach(requirement.coursesTaken) { course in
//                            Text("\(course.name)")
//                        }.padding(0)
//                    }
//                    Text(requirement.name).font(.headline).padding(0)
//               }
            
                    
                    
                    Button("Add") {
                        if (singleSelection != nil) {
                            //requirementViewModel.addRequirement(singleSelection!)
                            print(singleSelection!)
                            server.registerCSRF(){(json) in
                                let csrf = json.csrf_token
                                //server.updateRequirement(requirements: requirementViewModel.requirements, csrf: csrf)
                                print("csrf: " + csrf)
                            }
                        }
                    }
                }
            //}
        }
        }
}

//struct AddRequirementsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRequirementsView(requirementViewModel: RequirementsViewModel())
//    }
//}
