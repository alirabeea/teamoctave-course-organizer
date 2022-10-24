//
//  MainView.swift
//  CourseOrganizer_UI
//
//  Created by Giang Nguyen on 10/24/22.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var viewRouter: ViewRouter    
    var body: some View {
        switch viewRouter.currentScreen {
        case .inputCourse:
            InputCourse();
        case .loginView:
            LoginView();
        case .contentView:
            ContentView();
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(ViewRouter());
    }
}
