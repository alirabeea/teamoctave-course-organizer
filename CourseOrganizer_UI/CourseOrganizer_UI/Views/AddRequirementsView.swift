//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
<<<<<<< HEAD
    @State var requirementViewModel = RequirementsViewModel()
    @State private var singleSelection: UUID?
=======
    @ObservedObject var requirementViewModel: RequirementsViewModel
    @State private var singleSelection: Requirement?
>>>>>>> d460a3fb6ef9d0c2539891c6746d5bf4a3f147a8
    @State var requirementStr : String?
    var gradReq: [Requirement]
    let server = Server()
    var body: some View {
        NavigationView{
            VStack {
                Text("Requirements")
                    .font(.largeTitle)
                List(gradReq, id: \.self, selection: $singleSelection) { requirement in
                    Section(requirement.graduation_requirement) {
                        ForEach(requirement.courses_satisfying, id: \.self) { course in
                            Text(course)
                        }
                    }
                }
                    
                    
                Button("Add") {
                    if (singleSelection != nil) {
                        requirementViewModel.addRequirement(singleSelection!)
                        print(singleSelection!)
//                            server.registerCSRF(){(json) in
//                                let csrf = json.csrf_token
//                                //server.updateRequirement(requirements: requirementViewModel.requirements, csrf: csrf)
//                                print("csrf: " + csrf)
//                            }
                    }
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).navigationBarTitle("").navigationBarBackButtonHidden(true)
            }
        }
    }
}

<<<<<<< HEAD
struct AddRequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        AddRequirementsView()
    }
}
=======
//struct AddRequirementsView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRequirementsView(requirementViewModel: RequirementsViewModel())
//    }
//}
>>>>>>> d460a3fb6ef9d0c2539891c6746d5bf4a3f147a8
