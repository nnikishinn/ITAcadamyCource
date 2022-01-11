//
//  StudentCell.swift
//  StudentList
//
//  Created by Марина Елисеева on 21.11.21.
//

import UIKit

class StudentCell: UITableViewCell {
    let nameLabel = UILabel()
    let avatarImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(avatarImageView)
        avatarImageView.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            avatarImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
        ])
    }
}
