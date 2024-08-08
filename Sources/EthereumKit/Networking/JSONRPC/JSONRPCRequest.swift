//
//  JSONRPCRequest.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public protocol JSONRPCRequest {
    associatedtype Response
    
    var method: String { get }
    var parameters: Any? { get }
    
    func response(from resultObject: Any) throws -> Response
}

extension JSONRPCRequest {
    
    public var parameters: Any? {
        return nil
    }
}
