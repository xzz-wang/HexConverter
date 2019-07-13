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
