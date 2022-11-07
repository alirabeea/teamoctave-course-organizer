//
//  RequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/24/22.
//

import SwiftUI

struct RequirementsView: View {
    @ObservedObject var requirementViewModel = RequirementsViewModel()

    var body: some View {
        NavigationView{
            VStack {
                Text("Requirements")
                    .font(.largeTitle)
                ForEach(requirementViewModel.requirements, id: \.self) { item in
                    Text(item);
                }
                NavigationLink(destination: AddRequirementsView(requirementViewModel: requirementViewModel)){
                    Text("Add requirement")
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10)
            }
                
        }
            
        
    }
}

struct RequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        RequirementsView()
    }
}
