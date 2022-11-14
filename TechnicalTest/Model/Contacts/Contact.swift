//
//  Contact.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import Foundation

struct Contact {
    let firstName: String
    let lastName: String
    let status: ContactStatus
    let statusMessage: String
    let gender: ContactGender?
}

extension Contact: Decodable {
    private enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case status = "statusIcon"
        case statusMessage
        case gender
    }
}

enum ContactStatus: String {
    case online
    case away
    case busy
    case offline
    case callForwarding = "callforwarding"
    case pending
}

extension ContactStatus: Decodable { }

enum ContactGender: String {
    case male, female
}

extension ContactGender: Decodable { }
