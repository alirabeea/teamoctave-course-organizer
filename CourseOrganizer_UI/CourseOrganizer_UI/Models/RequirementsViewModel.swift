//
//  RequirementsViewModel.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/3/22.
//

import Foundation
import SwiftUI

class RequirementsViewModel: ObservableObject {
    @Published var requirements : Array<String> = [];
    
    func addRequirement(_ requirement: String) {
        self.requirements.insert(requirement, at: 0);
        print(self.requirements);
    }
}
