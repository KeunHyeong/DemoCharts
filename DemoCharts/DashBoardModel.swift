//
//  DashBoardModel.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

final class DashBoardModel: ObservableObject, DashBoardModelStateProtocol {}

extension DashBoardModel: DashBoardModelActionProtocol {}

extension DashBoardModel: DashBoardModelRouterProtocol {}

protocol DashBoardModelStateProtocol {}

protocol DashBoardModelActionProtocol {}

protocol DashBoardModelRouterProtocol {}
