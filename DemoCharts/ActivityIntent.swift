//
//  ActivityIntent.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

class ActivityIntent {
    private var actionsModel: ActivityModelActionProtocol
    private var routerModel: ActivityModelRouterProtocol
    
    init(model: ActivityModelActionProtocol & ActivityModelRouterProtocol) {
        actionsModel = model
        routerModel = model
    }
}

extension ActivityIntent: ActivityIntentProtocol {
    func viewOnInitialTask() {
        Task {
            await actionsModel.updateJSONData()
        }
    }
    
    func updateJSONData() {
        Task {
            await actionsModel.updateJSONData()
        }
    }
    
    func updateChartData() {
        actionsModel.updateChartData()
    }
}

protocol ActivityIntentProtocol {
    func viewOnInitialTask()
    func updateJSONData()
    func updateChartData()
}
