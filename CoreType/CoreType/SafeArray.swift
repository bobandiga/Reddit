//
//  SafeArray.swift
//  CoreType
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

final public class SafeArray<T> {
    
    private lazy var queue = DispatchQueue(label: "SafeArray", qos: .userInitiated, attributes: [.concurrent])
    private var array: [T] = []
    
    public init () {}
    
    public var count: Int {
        return queue.sync {
            return array.count
        }
    }
    
    public var elements: [T] {
        return queue.sync {
            return array
        }
    }
    
    public var first: T? {
        return queue.sync {
            return array.first
        }
    }
    
    public var last: T? {
        return queue.sync {
            return array.last
        }
    }
    
    public subscript(_ index: Int) -> T {
        set {
            queue.async(flags:.barrier) {
                self.array[index] = newValue
            }
        }
        get {
             return queue.sync {
                return array[index]
            }
        }
    }
    
    public func append(_ element: T) {
        queue.async(flags:.barrier) {
            self.array.append(element)
        }
    }
    
    public func set(_ sequence: [T]) {
        queue.async(flags:.barrier) {
            self.array = sequence
        }
    }
    
    public func append(_ sequence: [T]) {
        queue.async(flags:.barrier) {
            self.array.append(contentsOf: sequence)
        }
    }
    
    public func remove(at index: Int) {
        queue.async(flags:.barrier) {
            self.array.remove(at: index)
        }
    }
    
    
}
