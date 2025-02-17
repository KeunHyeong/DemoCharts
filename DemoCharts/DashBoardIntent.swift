//
//  DashBoardIntent.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class DashBoardIntent {
    private var actionsModel: DashBoardModelActionProtocol
    private var routerModel: DashBoardModelRouterProtocol
    
    init(model: DashBoardModelActionProtocol & DashBoardModelRouterProtocol) {
        actionsModel = model
        routerModel = model
    }
}

extension DashBoardIntent: DashBoardIntentProtocol {}

extension DashBoardIntent {}

protocol DashBoardIntentProtocol {}
