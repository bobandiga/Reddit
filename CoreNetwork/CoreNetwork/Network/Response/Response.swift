//
//  Response.swift
//  Core
//
//  Created by Максим Шаптала on 28.01.2021.
//

import Foundation

public struct Response {
    public var statusCode: Int
    public var data: Data
    
    public init(code: Int, data: Data) {
        self.statusCode = code
        self.data = data
    }
    
    public static func from(data: Data?, response: URLResponse?) -> Response? {
        guard let response = response as? HTTPURLResponse, response.statusCode < 300, response.statusCode > 199, let data = data else {
            return nil
        }
        return Response(code: response.statusCode, data: data)
    }
}
