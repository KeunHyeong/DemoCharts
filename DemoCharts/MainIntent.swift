//
//  MainIntent.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class MainIntent {
    private var actionsModel: MainModelActionProtocol
    private var routerModel: MainModelRouterProtocol
    
    init(model: MainModelActionProtocol & MainModelRouterProtocol) {
        actionsModel = model
        routerModel = model
    }
}

extension MainIntent: MainIntentProtocol {}

extension MainIntent {}

protocol MainIntentProtocol {}
