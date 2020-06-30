//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 29.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
