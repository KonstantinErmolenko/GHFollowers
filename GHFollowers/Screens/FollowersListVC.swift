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
                                          collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemRed
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width                = view.bounds.width
        let padding: CGFloat     = 12
        let itemSpacing: CGFloat = 10
        let availableWidth       = width - (padding * 2) - (itemSpacing * 2)
        let itemWidth            = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
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
