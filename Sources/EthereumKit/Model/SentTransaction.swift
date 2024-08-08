//
//  SentTransaction.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

/// Represents send transaction
public struct SentTransaction {
    
    /// Transaction ID published when broadcasting raw tx
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}
