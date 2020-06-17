//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 17.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username
    }
    
   @objc func dismissVC() {
        dismiss(animated: true)
    }
}
