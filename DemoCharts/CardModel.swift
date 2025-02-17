//
//  CardModel.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//

import Foundation

final class CardModel: ObservableObject, CardModelStateProtocol {}

extension CardModel: CardModelActionProtocol {}

extension CardModel: CardModelRouterProtocol {}

protocol CardModelStateProtocol {}

protocol CardModelActionProtocol {}

protocol CardModelRouterProtocol {}
