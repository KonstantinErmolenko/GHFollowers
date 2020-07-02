//
//  GFSecondaryTitleLable.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 21.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFSecondaryTitleLable: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configue()
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configue() {
        textColor          = .secondaryLabel
        minimumScaleFactor = 0.9
        lineBreakMode      = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
