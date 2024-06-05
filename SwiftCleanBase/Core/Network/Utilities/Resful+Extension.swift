//
//  Resful+Extension.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on R 6/06/02.
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
            case let .failure(error):
                print("❌ Error: \(error)")
                return .failure(error)
            case let .success(value):
                let data = try transform(value)
                print("✅ HTTP Response:")
                printPretty(data)
                return .success(data)
            }
        } catch {
            print("❌ Error: \(error)")
            return .failure(RestfulError.unKnown)
        }
    }
}

extension Publisher {
    func observer(_ completion: @escaping (RestfulFlow<Output>) -> Void) -> AnyCancellable {
        return receive(on: DispatchQueue.main).sink(receiveCompletion: { subscriptionCompletion in
            if let error = subscriptionCompletion.error   {
                completion(.failure(error))
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

func printPretty(_ object: Any) {
    let mirror = Mirror(reflecting: object)
    print("{")
    for (index, child) in mirror.children.enumerated() {
        if let label = child.label {
            let value = child.value
            let valueString = (value as? String) ?? "\(value)"
            print("  \"\(label)\": \"\(valueString)\"" + (index < mirror.children.count - 1 ? "," : ""))
        }
    }
    print("}")
}
