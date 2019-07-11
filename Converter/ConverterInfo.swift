//
//  BaseInfo.swift
//  Converter
//
//  Created by 王雪铮 on 6/26/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import Foundation
import SwiftUI

class ConverterInfo: Hashable, CaseIterable {
    
    enum BaseType {
        case binary = "Binary"
        case octal = "Octal"
        case decimal = "Decimal"
        case hex = "Hex"
    }
    var inputType: BaseType
    var inputBaseNumber: Int {
        get {
            switch inputType {
            case .binary:
                return 2
            case .octal:
                return 8
            case .decimal:
                return 10
            case .hex:
                return 16
            }
        }
    }
    
    
    // Input String Related
    var inputString = ""
    
    
    
    
    // INIT
    init(type baseType: BaseType) {
        self.baseType = baseType
    }
    
}

