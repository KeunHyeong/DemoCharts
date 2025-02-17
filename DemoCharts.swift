//
//  DelightLabsTestApp.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

@main
struct DemoCharts: App {
    let viewSetting = ViewSetting()

    var body: some Scene {
        WindowGroup {
            AppRootView()
                .environmentObject(viewSetting)

        }
    }
}

enum AppViews {
    case none
    case startView
    case startViewExpire
    case homeView
    case deviceAddressView
    case preProfileView
    case dangerMainView
    case dangerSurveyView
    case dangerResultView
    case onBoardingView
    case loginView
}

class ShowingView: ObservableObject {
    init(showingView: AppViews) {
        viewId = showingView
    }

    @Published var viewId: AppViews
}
