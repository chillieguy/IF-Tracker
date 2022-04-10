//
//  Fasts.swift
//  IF Tracker
//
//  Created by Chuck Underwood on 1/29/22.
//

import Foundation

struct Fasts: Identifiable, Hashable {
    var id: ObjectIdentifier
    var fastStart: Date
    var fastEnd: Date
    var inprogress: Bool
}
