//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
    @ObservedObject var requirementViewModel: RequirementsViewModel
    @State var requirementStr : String = "";
    var body: some View {
        NavigationView{
            VStack {
                Text("Add Requirements")
                    .font(.largeTitle)
                Spacer()
                TextField("Add Requirements", text: $requirementStr)
                    .padding()
                    .keyboardType(.emailAddress)
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(10)
                //add text fields for getting requirements to add
//                Button("Add", action:
//                    requirementViewModel.addRequirement(requirementStr)
//                    print(requirementStr);
//                    print(requirementViewModel.requirements)
//                ).foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10).onTapGesture
//                Spacer()
                Button("Add") {
                    requirementViewModel.addRequirement(requirementStr)
//                    print(requirementStr);
//                    print(requirementViewModel.requirements)
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
