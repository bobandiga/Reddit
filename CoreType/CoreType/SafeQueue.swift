//
//  SafeQueue.swift
//  CoreType
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

final public class SafeQueue<T> {
    
    private lazy var queue = DispatchQueue(label: "SafeQueue", qos: .userInitiated, attributes: [.concurrent])
    private var array: [T] = []
    
    public init () {}
    
    public var count: Int {
        return queue.sync {
            return array.count
        }
    }
//    
//    public var elements: [T] {
//        return queue.sync {
//            return array
//        }
//    }
    
    public var head: T? {
        return queue.sync {
            return array.first
        }
    }
    
    public var tail: T? {
        return queue.sync {
            return array.last
        }
    }
    
    public func enqueue(_ element: T) {
        queue.async(flags:.barrier) {
            self.array.append(element)
        }
    }
    
    public func dequeue() {
        queue.async(flags:.barrier) {
            guard !self.array.isEmpty else {
                return
            }
            self.array.removeFirst()
        }
    }
    
}
