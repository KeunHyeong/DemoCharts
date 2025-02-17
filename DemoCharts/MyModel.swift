//
//  MyModel.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

import Foundation

final class MyModel: ObservableObject, MyModelStateProtocol {}

extension MyModel: MyModelActionProtocol {}

extension MyModel: MyModelRouterProtocol {}

protocol MyModelStateProtocol {}

protocol MyModelActionProtocol {}

protocol MyModelRouterProtocol {}
