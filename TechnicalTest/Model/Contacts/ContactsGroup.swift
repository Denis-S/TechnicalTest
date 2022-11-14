//
//  ContactsGroup.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import Foundation

struct ContactsGroup {
    let title: String
    let contacts: [Contact]
}

extension ContactsGroup: Decodable {
    private enum CodingKeys: String, CodingKey {
        case title = "groupName"
        case contacts = "people"
    }
}
