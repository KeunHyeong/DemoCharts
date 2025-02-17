//
//  DashBoardView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

struct DashBoardView: View {
    @StateObject var container: MVIContainer<DashBoardIntentProtocol, DashBoardModelStateProtocol>
    
    private var intent: DashBoardIntentProtocol { container.intent }
    private var state: DashBoardModelStateProtocol { container.model }
    
    
    var body: some View {
        Text("DashBoard View")
    }
}

extension DashBoardView {
    static func build() -> some View {
        let model = DashBoardModel()
        let intent = DashBoardIntent(model: model)
        let container = MVIContainer(
            intent: intent as DashBoardIntentProtocol,
            model: model as DashBoardModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        let view = DashBoardView(container: container)
        return view
    }
}

//
//#Preview {
//    DashBoardView()
//}
