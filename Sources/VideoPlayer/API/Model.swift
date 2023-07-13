//
//  Model.swift
//  AVPlayerDemo
//
//  Created by Mac on 10/7/23.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let resource: Resource
    let id: Int
    let name: String
    let runs: Int
    let four, six: Bool
    let bye, legBye, noball, noballRuns: Int
    let isWicket, ball, out: Bool

    enum CodingKeys: String, CodingKey {
        case resource, id, name, runs, four, six, bye
        case legBye = "leg_bye"
        case noball
        case noballRuns = "noball_runs"
        case isWicket = "is_wicket"
        case ball, out
    }
}

enum Resource: String, Codable {
    case scores = "scores"
}
