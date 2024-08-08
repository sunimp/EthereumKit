//
//  DataConvertable.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public protocol DataConvertable {
    static func +(lhs: Data, rhs: Self) -> Data
    static func +=(lhs: inout Data, rhs: Self)
}

extension DataConvertable {
    public static func +(lhs: Data, rhs: Self) -> Data {
        var value = rhs
        let data = withUnsafePointer(to: &value) {
            Data(buffer: UnsafeBufferPointer(start: $0, count: 1))
        }
        return lhs + data
    }
    
    public static func +=(lhs: inout Data, rhs: Self) {
        lhs = lhs + rhs
    }
}

extension UInt8: DataConvertable {}
extension UInt32: DataConvertable {}

extension String {
    func toData() -> Data {
        return decomposedStringWithCompatibilityMapping.data(using: .utf8)!
    }
}
