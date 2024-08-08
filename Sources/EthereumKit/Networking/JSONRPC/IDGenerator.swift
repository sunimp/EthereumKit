//
//  IDGenerator.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public struct IDGenerator {
    private var currentId = 1
    
    public mutating func next() -> Int {
        defer { currentId += 1 }
        return currentId
    }
}
