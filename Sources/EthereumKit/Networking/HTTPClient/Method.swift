//
//  Method.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public enum Method: String {
    case get
    case post
    
    public var prefersQueryParameters: Bool {
        switch self {
        case .get:
            return true
        case .post:
            return false
        }
    }
}
