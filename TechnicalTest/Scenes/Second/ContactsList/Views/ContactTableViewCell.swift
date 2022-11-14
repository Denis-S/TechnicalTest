//
//  ContactTableViewCell.swift
//  TechnicalTest
//
//  Created by Denis Shalagin on 14.11.2022.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        statusImageView.image = nil
        statusLabel.text = nil
        avatarImageView.image = nil
    }
    
    func configure(with model: ContactCellViewModel) {
        nameLabel.text = model.fullName
        statusImageView.image = model.statusImage
        statusLabel.text = model.statusMessage
        avatarImageView.image = model.avatarImage
    }
}
