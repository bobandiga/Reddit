//
//  Networkable.swift
//  Core
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

public protocol Networkable {
    
    var urlComponents: URLComponents { get set }
    var headers: Headers { get }
    
    func prepareForRequest(request: Requestable) -> URLRequest?
}


