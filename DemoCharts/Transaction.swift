//
//  Account.swift
//  DelightLabsTest
//
//  Created by 장근형 on 1/9/25.
//
import Foundation

struct Transaction: Codable, Hashable {
    let amount: String
    let name: String
    let timestamp: String
    let type: String
    
    init(){
        amount = ""
        name = ""
        timestamp = ""
        type = ""
    }
    
    init(_ amount: String, _ name: String, _ timestamp: String, _ type: String) {
        self.amount = amount
        self.name = name
        self.timestamp = timestamp
        self.type = type
    }
}
