//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 28.05.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {

    var username: String!
    var collectionView: UICollectionView!
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configueViewController()
        configueCollectionView()
        getFollowers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - UI Configuration
    func configueViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configueCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemRed
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    // MARK: - Data recieving
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {

            case .success(let followers):
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad Stuf Happend",
                                                message: error.rawValue,
                                                buttonTitle: "Ok")
            }
        }
    }
}
