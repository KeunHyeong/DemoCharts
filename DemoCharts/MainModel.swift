//
//  MainModel.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

final class MainModel: ObservableObject, MainModelStateProtocol {}

extension MainModel: MainModelActionProtocol {}

extension MainModel: MainModelRouterProtocol {}

protocol MainModelStateProtocol {}

protocol MainModelActionProtocol {}

protocol MainModelRouterProtocol {}
