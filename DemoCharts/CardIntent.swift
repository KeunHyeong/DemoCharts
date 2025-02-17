//
//  CardIntent.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class CardIntent {
    private var actionsModel: CardModelActionProtocol
    private var routerModel: CardModelRouterProtocol
    
    init(model: CardModelActionProtocol & CardModelRouterProtocol) {
        actionsModel = model
        routerModel = model
    }
}

extension CardIntent: CardIntentProtocol {}

extension CardIntent {}

protocol CardIntentProtocol {}
