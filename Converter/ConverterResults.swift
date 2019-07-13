//
//  ConverterResult.swift
//  Converter
//
//  Created by Xuezheng Wang on 7/12/19.
//  Copyright © 2019 王雪铮. All rights reserved.
//

import Foundation
import SwiftUI
import os.log
import Combine

struct PropertyKey {
    static let value = "value"
    static let base = "base"
}

// MARK: - Results Class
public class ConverterResults: BindableObject {
    
    public var didChange = PassthroughSubject<Void, Never>()
    
    var results : [ConverterResult]
    
    init() {
        results = []
    }
    
    convenience init(fromDisk: Bool) {
        self.init()
        
        // Loading data from the disk. Dont know if this will work yet.
        if fromDisk {
            
        } else {
            // Spill some test data
            results = [ConverterResult(of: 64, in: .binary),
                       ConverterResult(of: 128, in: .hex)]
        }
    }
    
    func addResult(_ result: ConverterResult) {
        results.append(result)
        saveChanges()
    }
    
    func removeResult(at index: IndexSet.Element) {
        results.remove(at: index)
        
        saveChanges()
    }
    
    private func saveChanges() {
        // TODO: Save to disk
        
        // Notify Subscriber
        didChange.send()
    }
    
    
}


// MARK: - Result class
public class ConverterResult: NSObject, NSCoding, Identifiable {
    
    
    // MARK: Properties
    
    var value: Int
    var base: HexConverter.BaseTypes
    
    // Normal Initializer
    
    init(of value: Int, in base: HexConverter.BaseTypes) {
        self.value = value
        self.base = base
    }
    
    // MARK: NSCoding
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
