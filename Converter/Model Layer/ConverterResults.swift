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


// MARK: - Results Class
public class ConverterResults: BindableObject {
    
    let DATA_FILE = "Data.plist"
    
    public var didChange = PassthroughSubject<Void, Never>() // For Passing Values through SwiftUI
    var results : [ConverterResult]                         // The Property that stores all the data
    var docPath: URL?
    
    
    
    // Init a new Results Class
    init() {
        results = []
    }
    
    // Possibly init from the disk.
    convenience init(fromDisk: Bool) {
        self.init()
        
        // Loading data from the disk. Dont know if this will work yet.
        if fromDisk {
            do {
                try createDataPath()
            } catch {
                os_log("Can not create directory", type: .error)
            }

            let dataURL = docPath!.appendingPathComponent(DATA_FILE)
            guard let codedData = try? Data(contentsOf: dataURL) else { return }
            
            // 3
            let anyResult = try! (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData))
            results = anyResult as! [ConverterResult]
            print(results)

        } else {
            // Spill some test data
            results = [ConverterResult(of: 64, in: .binary),
                       ConverterResult(of: 128, in: .hex)]
        }
    }
    
    
    // MARK: -Modifing the data
    func addResult(_ result: ConverterResult) {
        results.append(result)
        saveChanges()
    }
    
    func removeResult(at index: IndexSet.Element) {
        results.remove(at: index)
        saveChanges()
    }
    
    func removeResult(_ targetResult: ConverterResult) -> Bool {
        for i in 1...results.endIndex {
            if results[i] === targetResult {
                results.remove(at: i)
                saveChanges()
                return true
            }
        }
        return false
    }
    
    
    // MARK: -Perform saving changes to the disk and notify all the views.
    private func saveChanges() {
        // TODO: Save to disk
        let dataURL = docPath!.appendingPathComponent(DATA_FILE)
        
        let codedData = try! NSKeyedArchiver.archivedData(withRootObject: results, requiringSecureCoding: false)
        
        do {
            try codedData.write(to: dataURL)
        } catch {
            os_log("Can not write to disk", type: .error)
        }
        
        print(dataURL.absoluteString)
        
        // Notify Subscriber
        didChange.send()
    }
    
    // Create a path
    func createDataPath() throws {
        guard docPath == nil else { return }
        
        // Create a save folder
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        docPath = paths.first!.appendingPathComponent("results")
        
        try FileManager.default.createDirectory(at: docPath!,
                                                withIntermediateDirectories: true,
                                                attributes: nil)
    }
    
    
}
