//
//  SMP+Extension.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//
//  https://github.com/mkrd/Swift-Big-Integer/pull/24

import Foundation

// TODO: use init(_:, radix:) in SMP but need to fix bugs
extension BInt {
    internal init?(str: String, radix: Int) {
        self.init(0)
        let bint16 = BInt(16)
        
        var exp = BInt(1)
        
        for c in str.reversed() {
            let int = Int(String(c), radix: radix)
            if int != nil {
                let value = BInt(int!)
                self = self + (value * exp)
                exp = exp * bint16
            } else {
                return nil
            }
        }
    }
}

extension BInt: Codable {
    private enum CodingKeys: String, CodingKey {
        case bigInt
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let string = try container.decode(String.self, forKey: .bigInt)
        self = Wei(number: string, withBase: 10)!
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(asString(withBase: 10), forKey: .bigInt)
    }
}
