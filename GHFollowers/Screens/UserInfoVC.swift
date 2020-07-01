//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 17.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

protocol UserInfoVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class UserInfoVC: GFDataLoadingVC {
    let scrollView          = UIScrollView()
    let contentView         = UIView()
    
    let headerView          = UIView()
    let itemViewOne         = UIView()
    let itemViewTwo         = UIView()
    let dateLabel           = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueViewController()
        configueScrollView()
        layoutUI()
        getUserInfo()
    }
    
    func configueViewController() {
        view.backgroundColor = .systemBackground

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(dismissVC)
        )
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = username
    }
    
    func configueScrollView() {
        view.addSubview(scrollView)
        scrollView.pinToEdges(of: view)
        
        scrollView.addSubview(contentView)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 615)
        ])
    }
    
    func configueUIElements(with user: User) {
        self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        scrollView.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        let itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        for itemView in itemViews {
            itemView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -padding)
            ])
        }
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    @objc func dismissVC() {
         dismiss(animated: true)
     }
     
     func getUserInfo() {
         NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
             guard let self = self else { return }
             
             switch result{
             case .success(let user):
                 DispatchQueue.main.async {
                     self.configueUIElements(with: user)
                 }
             case .failure(let error):
                 self.presentGFAlertOnMainThread(title: "Something went wrong.",
                                                 message: error.rawValue,
                                                 buttonTitle: "Ok")
             }
         }
     }
}

extension UserInfoVC: GFRepoItemVCDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(
                title: "Invalid URL",
                message: "The url attached to this user is invalid",
                buttonTitle: "OK"
            )
            return
        }
        
        presentSafariVC(with: url) 
    }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(
                title: "No followers",
                message: "This user has no followers",
                buttonTitle: "So sad"
            )
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
