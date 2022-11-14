//
//  String+Localize.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import Foundation

public extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
