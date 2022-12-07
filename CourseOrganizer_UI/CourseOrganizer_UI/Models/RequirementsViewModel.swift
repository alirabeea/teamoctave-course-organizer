//
//  RequirementsViewModel.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/3/22.
//

import Foundation
import SwiftUI

class RequirementsViewModel: ObservableObject {
    @Published var chosenRequirement : Array<Requirement> = [];
    let server = Server()
    @State var requirements = [Requirement]()
    
    //determine if requirement is filled or not
    func isCompleted(requirement: Requirement) -> Bool{
        //return requirement.numCourses == requirement.coursesTaken.count
        return false
    }
    
    func setRequirement(_ req: [Requirement]) {
        self.requirements = req
    }
    
    func getRequirement() -> [Requirement]{
        return self.chosenRequirement
    }
    
    func addRequirement(_ requirement: Requirement) {
        self.chosenRequirement.insert(requirement, at: 0);
    }
}
