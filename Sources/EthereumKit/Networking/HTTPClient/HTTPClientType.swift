//
//  HTTPClientType.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public protocol HTTPClientType {
    @discardableResult
    func send<Request: RequestType>(
        _ request: Request,
        completionHandler: @escaping (Result<Request.Response>) -> Void) -> Cancellable?
    
    @discardableResult
    func send<Request: JSONRPCRequest>(
        _ request: Request,
        completionHandler: @escaping (Result<Request.Response>) -> Void) -> Cancellable?
}
