//
//  SafeType.swift
//  CoreType
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

public class SafeType<T>  {
    
    private lazy var queue = DispatchQueue(label: "SafeType", qos: .userInitiated, attributes: [.concurrent])
    
    public var wrappedValue: T {
        get {
            return queue.sync {
                return value
            }
        }
        set {
            queue.async(flags: .barrier) {
                self.value = newValue
            }
        }
    }
    
    private var value: T
    
    public init(_ value: T) {
        self.value = value
    }
    
}
