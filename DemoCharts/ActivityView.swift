//
//  ActivitiView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

struct ActivityView: View {
    @StateObject var container: MVIContainer<ActivityIntentProtocol, ActivityModelStateProtocol>
    
    private var intent: ActivityIntentProtocol { container.intent }
    private var state: ActivityModelStateProtocol { container.model }
    
    @State private var showToast: Bool = false
    @State private var transaction: Transaction = Transaction()
    
    var content: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text("Activity")
                    .frame(height: 102)
                    .bold()
                    .font(.largeTitle)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            ScrollView {
                VStack {
                    HStack(spacing: 20) {
                        ForEach(TabMenu.allCases, id: \.self) { menu in
                            HStack(spacing: 10) {
                                Rectangle()
                                    .fill(menu == .week ? Color.deepBlue : Color.cyon)
                                    .frame(width: 32, height: 5)
                                
                                Text(menu.lineLabel)
                                    .foregroundStyle(Color.deepBlue)
                            }
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
//                    TabMenuView(selectedTabMenu: $container.model.selectedTabMenuView)
                    
                    ChartView(selectecdTab: $container.model.selectedTabMenuView,
                              incomeData: $container.model.incomeData,
                              expenseData: $container.model.expenseData,
                              selectTab: intent.updateChartData)
                    
                    RecentTransView(selectedRecentTransMenu: $container.model.selectedRecentTrans)
                    
                    VStack(spacing: 10) {
                        ForEach(state.transactions, id: \.self) { item in
                            RecentTransCellView(selectedRecentTransMenu: $container.model.selectedRecentTrans,
                                                transaction: item)
                            .onTapGesture {
                                self.transaction = item
                                showToast = true
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 20)
    }
    
    var body: some View {
        content
            .initialTask(perform: intent.viewOnInitialTask)
            .onChange(of: container.model.selectedRecentTrans) { _, _ in
                intent.updateJSONData()
            }
            .toast(isPresented: $showToast, transaction: self.transaction, duration: 1)
    }
}

extension ActivityView {
    static func build() -> some View {
        let model = ActivityModel()
        let intent = ActivityIntent(model: model)
        let container = MVIContainer(
            intent: intent as ActivityIntentProtocol,
            model: model as ActivityModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        let view = ActivityView(container: container)
        return view
    }
}

//#Preview {
//    let model = ActivityModel()
//    let intent = ActivityIntent(model: model)
//    let container = MVIContainer(
//        intent: intent as ActivityIntentProtocol,
//        model: model as ActivityModelStateProtocol,
//        modelChangePublisher: model.objectWillChange
//    )
//    
//    let view = ActivityView(container: container, selectedTabMenuView: .week, selectedRecentTransMenu: .all)
//    return view
//}
