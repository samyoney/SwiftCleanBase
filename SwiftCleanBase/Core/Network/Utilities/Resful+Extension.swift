//
//  Resful+Extension.swift
//  SwiftCleanBase
//
//  Created by HS-Macbook on R 6/06/02.
//

import Foundation
import Combine
import SwiftUI

extension Just where Output == Void {
    static func withErrorType<E>(_ errorType: E.Type) -> AnyPublisher<Void, E> {
        return withErrorType((), E.self)
    }
}

extension Just {
    static func withErrorType<E>(_ value: Output, _ errorType: E.Type
    ) -> AnyPublisher<Output, E> {
        return Just(value)
            .setFailureType(to: E.self)
            .eraseToAnyPublisher()
    }
}

extension RestfulFlow {
    func map<V>(_ transform: (T) throws -> V) -> RestfulFlow<V> {
        do {
            switch self {
            case let .failure(error): return .failure(error)
            case let .success(value):
                return .success(try transform(value))
            }
        } catch {
            return .failure(RestfulError.unKnown.message)
        }
    }
}

extension Publisher {
    func observer(_ completion: @escaping (RestfulFlow<Output>) -> Void) -> AnyCancellable {
        return sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error   {
                completion(.failure(error.message))
            }
        }, receiveValue: { value in
            completion(.success(value))
        })
    }
        
    func ensureTimeSpan(_ interval: TimeInterval) -> AnyPublisher<Output, Failure> {
        let timer = Just<Void>(())
            .delay(for: .seconds(interval), scheduler: RunLoop.main)
            .setFailureType(to: Failure.self)
        return zip(timer)
            .map { $0.0 }
            .eraseToAnyPublisher()
    }
}

extension Subscribers.Completion {
    var error: RestfulError? {
        switch self {
        case let .failure(error): return error as? RestfulError ?? RestfulError.unKnown
        default: return nil
        }
    }
}
