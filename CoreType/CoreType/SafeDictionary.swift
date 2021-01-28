//
//  SafeDictionary.swift
//  CoreType
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

final public class SafeDictionary<T> {
    
    private lazy var queue = DispatchQueue(label: "SafeDictionaty", qos: .userInitiated, attributes: [.concurrent])
    private var dictionary: [String: T] = [:]
    
    public init () {}
    
    public var count: Int {
        return queue.sync {
            return dictionary.count
        }
    }
    
    public subscript(_ key: String) -> T? {
        set {
            queue.async(flags:.barrier) {
                self.dictionary[key] = newValue
            }
        }
        get {
             return queue.sync {
                return dictionary[key]
            }
        }
    }
    
}
