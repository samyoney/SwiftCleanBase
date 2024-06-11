//
//  ViewModel.swift
//  SwiftCleanBase
//
//  Created by グェン・ホン・ソン on 2024/06/11.
//

import Foundation

@MainActor
protocol ViewModel<State, Event>: ObservableObject where State: Equatable {
    associatedtype State
    associatedtype Event

    var state: State { get }

    func onTriggerEvent(_ eventType: Event)
}

