//
//  ConverterResult.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/13/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import Foundation
import SwiftUI
import os.log

public class ConverterResult: NSObject, NSCoding, Identifiable {
    
    
    // MARK: Properties
    
    var value: Int
    var base: HexConverter.BaseTypes
    
    
    // Normal Initializer
    
    init(of value: Int, in base: HexConverter.BaseTypes) {
        self.value = value
        self.base = base
    }
    
    
    // MARK: NSCoding Methods
    public func encode(with coder: NSCoder) {
        coder.encode(value, forKey: PropertyKey.value)
        coder.encode(base, forKey: PropertyKey.base)
    }
    
    public required init?(coder: NSCoder) {
        let value = coder.decodeObject(forKey: PropertyKey.value)
        let base = coder.decodeObject(forKey: PropertyKey.base)
        
        if value == nil || base == nil {
            os_log("Can not load the properties", type: .debug)
            return nil
        }
        
        self.value = value as! Int
        self.base = base as! HexConverter.BaseTypes
    }
    
}
