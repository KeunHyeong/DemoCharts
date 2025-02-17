//
//  MyView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

struct MyView: View {
    @StateObject var container: MVIContainer<MyIntentProtocol, MyModelStateProtocol>
    
    private var intent: MyIntentProtocol { container.intent }
    private var state: MyModelStateProtocol { container.model }
    var body: some View {
        Text("MyView")
    }
}

extension MyView {
    static func build() -> some View {
        let model = MyModel()
        let intent = MyIntent(model: model)
        let container = MVIContainer(
            intent: intent as MyIntentProtocol,
            model: model as MyModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        let view = MyView(container: container)
        return view
    }
}
