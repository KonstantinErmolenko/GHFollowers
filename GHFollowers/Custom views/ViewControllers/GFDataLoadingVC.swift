//
//  GFDataLoadingVC.swift
//  GHFollowers
//
//  Created by Ермоленко Константин on 29.06.2020.
//  Copyright © 2020 Ермоленко Константин. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {

    var containerView: UIView!

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.alpha           = 0
        containerView.backgroundColor = .systemBackground
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }

        let activityIndicator = UIActivityIndicatorView()
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25) {
                self.containerView.alpha = 0
            }
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
     }
}
