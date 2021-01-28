//
//  File.swift
//  
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation


extension String {
    func year(intereval: Int?) -> String? {
        guard self == "", let i = intereval, i > 0 else {
            return self
        }
        return i == 1 ? "\(i) year ago" : "\(i) years ago"
    }
    
    func month(intereval: Int?) -> String? {
        guard  self == "", let i = intereval, i > 0 else {
            return self
        }
        return i == 1 ? "\(i) month ago" :"\(i) month's ago"
    }
    
    func day(intereval: Int?) -> String? {
        guard self == "", let i = intereval, i > 0 else {
            return self
        }
        return i == 1 ? "\(i) day ago" : "\(i) days ago"
    }
    
    func hour(intereval: Int?) -> String? {
        guard self == "", let i = intereval, i > 0 else {
            return self
        }
        return i == 1 ? "\(i) hour ago" : "\(i) hours ago"
    }
    
    func minute(intereval: Int?) -> String? {
        guard self == "", let i = intereval, i > 0 else {
            return self
        }
        return i == 1 ? "\(i) minute ago" : "\(i) minutes ago"
    }
    
    func sec(intereval: Int?) -> String? {
        guard self == "", let i = intereval, i > 0 else {
            return self
        }
        return i == 1 ? "\(i) second ago" : "\(i) seconds ago"
    }
    
    func moment() -> String? {
        guard self == "" else { return self }
        return "a moment ago"
    }
}
