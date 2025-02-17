//
//  CardView.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import SwiftUI

struct CardView: View {
    @StateObject var container: MVIContainer<CardIntentProtocol, CardModelStateProtocol>
    
    private var intent: CardIntentProtocol { container.intent }
    private var state: CardModelStateProtocol { container.model }
    
    var body: some View {
        Text("Card View")
    }
}

extension CardView {
    static func build() -> some View {
        let model = CardModel()
        let intent = CardIntent(model: model)
        let container = MVIContainer(
            intent: intent as CardIntentProtocol,
            model: model as CardModelStateProtocol,
            modelChangePublisher: model.objectWillChange
        )
        let view = CardView(container: container)
        return view
    }
}
