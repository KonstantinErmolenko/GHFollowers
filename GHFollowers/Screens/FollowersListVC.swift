//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 28.05.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

protocol FollowersListVCDelegate: class {
    func didRequestFollowers(for username: String)
}

class FollowersListVC: GFDataLoadingVC {

    enum Section { case main }
     
    var username: String!
    var followers: [Follower] = []
    var hasMoreFollowers = true
    var page = 1

    var isSearched = false
    var filteredFollowers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title         = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configueViewController()
        configueSearchController()
        configueCollectionView()
        getFollowers(for: username, on: page)
        configueDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - UI Configuration
    func configueViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true

        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addButtonTapped)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    func configueCollectionView() {
        collectionView = UICollectionView(
            frame: view.bounds,
            collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view)
        )
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configueSearchController() {
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
     
    // MARK: - Data recieving
    func getFollowers(for username: String, on page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.hasMoreFollowers = followers.count == 100
                self.followers.append(contentsOf: followers)
                if followers.isEmpty {
                    let message = "This user doesn't have any followers 😔."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(
                    title: "Bad Stuf Happend",
                    message: error.rawValue,
                    buttonTitle: "Ok"
                )
            }
        }
    }
    
    func configueDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: FollowerCell.reuseID,
                for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    @objc func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateFavorites(with: favorite, action: .add) { [weak self] error in
                    guard let self = self else { return }
                    guard let error = error else {
                        self.presentGFAlertOnMainThread(title: "Sucsess!", message: "You have successfully favorited this user.", buttonTitle: "Ok")
                        return
                    }
                    self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY       = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height        = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(for: username, on: page)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = isSearched ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = follower.login
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}

extension FollowersListVC: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.lowercased(), !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearched = false
            return
        }
        
        isSearched = true
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter)}
        updateData(on: filteredFollowers)
    }
}

extension FollowersListVC: FollowersListVCDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title          = username
        page          = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(for: username, on: page)
    }
}
