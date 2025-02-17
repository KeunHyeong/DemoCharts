//
//  ViewSetting.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

final class ViewSetting: ObservableObject {
    @Published var selectedTab: MainViewType = .activity
}

enum MainViewType: CaseIterable, Hashable {
    case my
    case card
    case activity
    case dashboard

    static var allCases: [MainViewType] = [
        .my,
        .card,
        .activity,
        .dashboard
    ]
    
    var selectedIcon: String {
        switch self {
        case .my: return "figma_icon_my"
        case .card: return "figma_icon_card"
        case .activity: return "figma_icon_activity_select"
        case .dashboard: return "figma_icon_dashboard"
        }
    }
    
    var unSelectedIcon: String {
        switch self {
        case .my: return "figma_icon_my"
        case .card: return "figma_icon_card"
        case .activity: return "figma_icon_activity_unselect"
        case .dashboard: return "figma_icon_dashboard"
        }
    }
}

