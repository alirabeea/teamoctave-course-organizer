//
//  AddRequirementsView.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 11/2/22.
//

import SwiftUI

struct AddRequirementsView: View {
    var body: some View {
        NavigationView{
            VStack {
                Text("Add Requirements")
                    .font(.largeTitle)
               Spacer()
                //add text fields for getting requirements to add
                NavigationLink(destination: AddRequirementsView()){
                    Text("Add requirement")
                }.foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10)
                Spacer()
            }
                
        }
    }
}

struct AddRequirementsView_Previews: PreviewProvider {
    static var previews: some View {
        AddRequirementsView()
    }
}
