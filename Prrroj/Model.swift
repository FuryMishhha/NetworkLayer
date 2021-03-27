//
//  Model.swift
//  Prrroj
//
//  Created by student on 27.03.2021.
//

import Foundation

// MARK: - WelcomeElement
struct WelcomeElement: Codable {
    let id: Int
    let firstName, lastName, email: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, avatar
    }
}

typealias Model = [WelcomeElement]
