//
//  ContactCellViewModel.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import UIKit

struct ContactCellViewModel {
    let fullName: String
    let statusImage: UIImage?
    let statusMessage: String?
    let avatarImage: UIImage?
    
    init(contact: Contact) {
        fullName = contact.fullName
        statusImage = contact.statusIcon
        statusMessage = contact.statusMessage
        avatarImage = contact.avatarIcon
    }
}

extension Contact {
    var fullName: String {
        return firstName + " " + lastName
    }
    
    var avatarIcon: UIImage? {
        switch gender {
        case .male:
            return UIImage(named: "contacts_list_avatar_male")
        case .female:
            return UIImage(named: "contacts_list_avatar_female")
        default:
            return UIImage(named: "contacts_list_avatar_unknown")
        }
    }
    
    var statusIcon: UIImage? {
        switch status {
        case .online:
            return UIImage(named: "contacts_list_status_online")
        case .away:
            return UIImage(named: "contacts_list_status_away")
        case .busy:
            return UIImage(named: "contacts_list_status_busy")
        case .offline:
            return UIImage(named: "contacts_list_status_offline")
        case .callForwarding:
            return UIImage(named: "contacts_list_call_forward")
        case .pending:
            return UIImage(named: "contacts_list_status_pending")
        }
    }
}
