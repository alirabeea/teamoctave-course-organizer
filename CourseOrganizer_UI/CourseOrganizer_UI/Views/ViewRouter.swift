//
//  ViewRouter.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 10/24/22.
//

import Foundation
import SwiftUI

enum Screen {
    case contentView
    case loginView
    case inputCourse
}

class ViewRouter: ObservableObject {
    @Published var currentScreen: Screen = .loginView
}
