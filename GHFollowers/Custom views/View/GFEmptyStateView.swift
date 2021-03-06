//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 06.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel  = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configue() {
        addSubviews(messageLabel, logoImageView)
        configueMessageLabel()
        configueLogoImageView()
        backgroundColor = .systemBackground
    }
    
    func configueMessageLabel() {
        messageLabel.textColor     = .secondaryLabel
        messageLabel.numberOfLines = 3
        
        let topConstant: CGFloat = DeviceTypes.isSmallScreenSize() ? -85 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                                  constant: topConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configueLogoImageView() {
        logoImageView.image = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstant: CGFloat = DeviceTypes.isSmallScreenSize() ? 85 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: bottomConstant)
        ])
    }
}
