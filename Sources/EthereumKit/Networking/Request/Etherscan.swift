//
//  Etherscan.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public final class Etherscan {
    public struct GetTransactions: RequestType {
        public typealias Response = Transactions
        
        public enum Sort: String {
            case asc, des
        }
        
        public struct Configuration {
            public let baseURL: URL
            public let apiKey: String
            
            public init(baseURL: URL, apiKey: String) {
                self.baseURL = baseURL
                self.apiKey = apiKey
            }
        }
        
        public let configuration: Configuration
        public let address: String
        public let sort: Sort
        public let startBlock: Int64
        public let endBlock: Int64
        
        public var baseURL: URL {
            return configuration.baseURL
        }
        
        public var method: Method {
            return .get
        }
        
        public var path: String {
            return "api"
        }
        
        public var parameters: Any? {
            return [
                "module": "account",
                "action": "txlist",
                "address": address,
                "startblock": NSNumber(value: startBlock),
                "endblock": NSNumber(value: endBlock),
                "sort": sort.rawValue,
                "apikey": configuration.apiKey
            ]
        }
    }
}
