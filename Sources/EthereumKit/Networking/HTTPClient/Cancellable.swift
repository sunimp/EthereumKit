//
//  Cancellable.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public protocol Cancellable: AnyObject {
    func cancel()
}

extension URLSessionTask: Cancellable {}
