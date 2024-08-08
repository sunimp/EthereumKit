//
//  WordList.swift
//  EthereumKit
//
//  Created by Sun on 2024/8/8.
//

import Foundation

public enum WordList {
    case english
    case japanese
    
    public var words: [String] {
        switch self {
        case .english:
            return englishWords
        case .japanese:
            return japaneseWords
        }
    }
}
