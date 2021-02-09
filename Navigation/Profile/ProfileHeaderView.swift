//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Иван Каменев on 15.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import Foundation

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var statusText: String = ""
    let nameTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "My name"
        textLabel.textColor = .black
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return textLabel
    }()
    
    let statusTextLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Waiting for something..."
        textLabel.textColor = .gray
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .left
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textLabel
    }()
    
    var avatarImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width/2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.roundCornersWithRadius(12, top: true, bottom: true, shadowEnabled: true)
        return button
    }()
    
    let statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.placeholder = "Write your status"
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.autocorrectionType = .no
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self, action: #selector(statusTextChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = statusTextField.text ?? "Enter your status"
    }
    
    @objc func buttonPressed() {
        statusTextLabel.text = statusText
        print(statusText)
    }
    
    private func setupViews() {
        
        contentView.backgroundColor = .lightGray
        contentView.addSubviews(avatarImageView, nameTextLabel, statusTextLabel, statusButton, statusTextField)
        
        let constraints = [
            
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: 16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
           
            nameTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
            nameTextLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            nameTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusTextLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            statusTextLabel.topAnchor.constraint(equalTo: nameTextLabel.bottomAnchor, constant: 10),
            statusTextLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -44),
            statusTextLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            statusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16),
            statusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            statusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            statusTextField.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 20),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -10)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }

    
}

extension UIView {
    
    /// Method adds shadow and corner radius for top of view by default.
    ///
    /// - Parameters:
    ///   - top: Top corners
    ///   - bottom: Bottom corners
    ///   - radius: Corner radius
    func roundCornersWithRadius(_ radius: CGFloat, top: Bool? = true, bottom: Bool? = true, shadowEnabled: Bool = true) {
        var maskedCorners = CACornerMask()
        
        if shadowEnabled {
            clipsToBounds = true
            layer.masksToBounds = false
            layer.shadowOpacity = 0.7
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowRadius = 10
            layer.shadowOffset = CGSize(width: 4, height: 4)
        }
        
        switch (top, bottom) {
        case (true, false):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case (false, true):
            maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case (true, true):
            maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        default:
            break
        }
        
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorners
    }
    
}
