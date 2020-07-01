//
//  UITableView+Ext.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 01.07.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
