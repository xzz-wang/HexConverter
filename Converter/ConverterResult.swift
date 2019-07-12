//
//  ConverterResult.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/12/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import Foundation
import SwiftUI

public class ConverterResult: Identifiable {
    var value: Int
    var base: HexConverter.BaseTypes
    
    init(of value: Int, in base: HexConverter.BaseTypes) {
        self.value = value
        self.base = base
    }
}
