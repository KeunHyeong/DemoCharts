//
//  MyIntent.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class MyIntent {
    private var actionsModel: MyModelActionProtocol
    private var routerModel: MyModelRouterProtocol
    
    init(model: MyModelActionProtocol & MyModelRouterProtocol) {
        actionsModel = model
        routerModel = model
    }
}

extension MyIntent: MyIntentProtocol {}

extension MyIntent {}

protocol MyIntentProtocol {}
