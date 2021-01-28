//
//  SafeRefType.swift
//  CoreType
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

public class SafeRefType<T: AnyObject>  {
    
    private lazy var queue = DispatchQueue(label: "SafeType", qos: .userInitiated, attributes: [.concurrent])
    
    public var wrappedValue: T {
        get {
            return queue.sync {
                return value.value
            }
        }
        set {
            
            queue.async(flags: .barrier) { [weak self] in
                guard let strongSelf = self else { return }
                guard isKnownUniquelyReferenced(&strongSelf.value) else {
                    strongSelf.value = Ref(newValue)
                    return
                }
                strongSelf.value.value = newValue
            }
        }
    }
    
    private var value: Ref<T>
    
    public init(_ value: T) {
        self.value = Ref(value)
    }
    
}

final fileprivate class Ref<T> {
    var value: T
    
    init(_ value: T) {
        self.value = value
    }
}
