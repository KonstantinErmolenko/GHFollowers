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
        configueNavigationBar()
        populateUserInfo()
    }
    
    func configueNavigationBar() {
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
    
    func populateUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.",
                                                message: error.rawValue,
                                                buttonTitle: "Ok")
            }
        }
    }
}
