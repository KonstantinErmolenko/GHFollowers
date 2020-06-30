//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 24.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController {

    let stackView    = UIStackView()
    let itemViewOne  = GFItemInfoView()
    let itemViewTwo  = GFItemInfoView()
    let actionButton = GFButton()
    
    var user: User!
    weak var delegate: UserInfoVCDelegate!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configueBackgroundView()
        configueActionButton()
        configueStackView()
        layoutUI()
    }
    
    private func configueBackgroundView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 18
    }
    
    private func configueStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemViewOne)
        stackView.addArrangedSubview(itemViewTwo)
    }
    
    func configueActionButton() {
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    @objc func actionButtonTapped() {}
    
    private func layoutUI() {
        view.addSubviews(stackView, actionButton)

        let padding: CGFloat = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
