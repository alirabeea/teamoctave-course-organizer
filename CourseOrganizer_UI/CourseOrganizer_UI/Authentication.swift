//
//  Authentication.swift
//  CourseOrganizer_UI
//
//  Created by Sally Rademacher on 10/23/22.
//

import SwiftUI

class Authentication: ObservableObject {
    @Published var isValidated = false
    
    func updateValidation(success: Bool) {
        withAnimation {
            isValidated = success
        }
    }
}
