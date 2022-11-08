//
//  RequirementsViewModel.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 11/3/22.
//

import Foundation
import SwiftUI

class RequirementsViewModel: ObservableObject {
//    struct Req: Identifiable, Hashable {
//        let name: String
//        let id = UUID()
//    }
    
    @Published var requirements : Array<String> = [];
    @State var selection: Array<String> = ["Junior Year Writing (JYW) Requirement", "Intergrative Experience Requirement", "Introductory Computer Science Courses", "Core Computer Science Courses", "Mathmatics Courses", "Upper-Level Elective Computer Science Courses"]

    func addRequirement(_ requirement: String) {
        self.requirements.insert(requirement, at: 0);
        print(self.requirements);
    }
}
