//
//  HomeView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var viewSetting: ViewSetting
    @StateObject var container: MVIContainer<MainIntentProtocol, MainModelStateProtocol>
    @State private var selectedTab: MainViewType = .activity // 선택 상태 변수
    
    private var intent: MainIntentProtocol { container.intent }
    private var state: MainModelStateProtocol { container.model }
    
    private let myView: some View = MyView.build().tag(MainViewType.my)
    private let cardView: some View = CardView.build().tag(MainViewType.card)
    private let activityView: some View = ActivityView.build().tag(MainViewType.activity)
    private let dashBoardView: some View = DashBoardView.build().tag(MainViewType.dashboard)
    
    var body: some View {
        ZStack {
            VStack(spacing: 0 ){
                Group {
                    switch viewSetting.selectedTab {
                    case .my: myView
                    case .card: cardView
                    case .activity: activityView
                    case .dashboard: dashBoardView
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                HStack(alignment: .center, spacing: 0) {
                    ForEach(MainViewType.allCases, id: \.self) { mainViewType in
                        Button {
                            viewSetting.selectedTab = mainViewType
                        } label: {
                            VStack {
                                Image(viewSetting.selectedTab == mainViewType ? mainViewType.selectedIcon: mainViewType.unSelectedIcon)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 24, height: 24)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .contentShape(Rectangle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                
            }
        }
    }
}

extension MainView {
    static func build() -> some View {
        let model = MainModel()
        let intent = MainIntent(model: model)
        let container = MVIContainer(
            intent: intent as MainIntentProtocol,
            model: model as MainModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        let view = MainView(container: container)
        return view
    }
}
