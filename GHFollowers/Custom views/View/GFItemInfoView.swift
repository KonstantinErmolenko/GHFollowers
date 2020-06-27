//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 24.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

enum itemInfoType: String {
    case repos, gists, followers, following
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configue() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4 ),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    func set(itemInfoType: itemInfoType, with count: Int) {
        
        switch itemInfoType {
        case .repos:
            titleLabel.text       = "Public Repos"
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
        case .gists:
            titleLabel.text       = "Public Gists"
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
        case .followers:
            titleLabel.text       = "Followers"
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
        case .following:
            titleLabel.text       = "Following"
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
        }
        
        countLabel.text = String(count)
    }
}
