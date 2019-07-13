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





public class ConverterResults: BindableObject {
    
    public var didChange = PassthroughSubject<Void, Never>()
    
    // Document File path
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("converterResults")
    
    var results : [ConverterResult]
    
    init() {
        results = []
    }
    
    convenience init(fromDisk: Bool) {
        self.init()
        
        if fromDisk {
            if let nsData = NSData(contentsOf: ConverterResults.ArchiveURL) {
                do {
                    let data = Data(referencing:nsData)
                    
                    if let loadedResults = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<ConverterResult> {
                        results = loadedResults
                        didChange.send()
                    }
                } catch {
                    print("Couldn't read file.")
                }
            }
        }
    }
    
    func addResult(_ result: ConverterResult) {
        results.append(result)
        saveChanges()
    }
    
    //TODO: Remove items from the list
    
    private func saveChanges() {
        // Save to disk
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: results, requiringSecureCoding: false)
            try data.write(to: ConverterResults.ArchiveURL)
            
            os_log("Results successfully saved.", log: OSLog.default, type: .debug)
        } catch {
            os_log("Failed to save results...", log: OSLog.default, type: .error)
        }
        
        // Notify Subscriber
        didChange.send()
    }
    
    
}
