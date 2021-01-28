//
//  RequestType.swift
//  Core
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

public enum RequestType {
    
    case simple
    case upload(data: Data?)
    case download
    
}
