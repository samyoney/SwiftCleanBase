//
//  RestfulResponse.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/03.
//

import Foundation

struct RestfulResponse {
    let data: Data
    let response: HTTPURLResponse
    
    func parseJson<T: Decodable>() throws -> T {
        if data.isEmpty {
            throw RestfulError.notFound
        }
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            throw RestfulError.dataError(error)
        }
    }
}
