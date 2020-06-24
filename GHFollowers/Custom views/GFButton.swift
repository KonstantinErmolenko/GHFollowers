//
//  GFButton.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 26.05.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configue()
    }
        
    private func configue() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
