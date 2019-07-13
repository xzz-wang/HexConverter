//
//  ConverterResult.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/13/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import os.log

public class ConverterResult: NSObject, NSCoding, Identifiable, BindableObject {
    
    public var didChange = PassthroughSubject<Void, Never>() // For Passing Values through SwiftUI
    
    // MARK: Properties
    
    var value: Int
    var base: HexConverter.BaseTypes
    var createdTime: Date
    
    
    // Normal Initializer
    
    init(of value: Int, in base: HexConverter.BaseTypes) {
        self.value = value
        self.base = base
        self.createdTime = Date(timeIntervalSinceNow: 0)
    }
    
    // MARK: NSCoding Methods
    public func encode(with coder: NSCoder) {
        coder.encode(value, forKey: PropertyKey.value)
        coder.encode(base.getName(), forKey: PropertyKey.base)
        coder.encode(createdTime as NSDate, forKey: PropertyKey.createdTime)
    }
    
    public required init?(coder: NSCoder) {
        let value = coder.decodeInt64(forKey: PropertyKey.value)
        let base = coder.decodeObject(forKey: PropertyKey.base)
        let date = coder.decodeObject(forKey: PropertyKey.createdTime)
        
        if base == nil || date == nil {
            os_log("Can not load the properties", type: .debug)
            return nil
        }
        
        self.value = Int(value)
        let baseString = base as! String
        self.base = HexConverter.BaseTypes(rawValue: baseString)!
        self.createdTime = date as! Date
    }
    
}

struct PropertyKey {
    static let value = "value"
    static let base = "base"
    static let createdTime = "time"
}
