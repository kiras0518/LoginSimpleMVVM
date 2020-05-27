//
//  WelcomeVC.swift
//  Login
//
//  Created by kiras on 2020/5/26.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    lazy var nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Welcome"
        lb.backgroundColor = .systemPink
        lb.textAlignment = .center
        lb.font = .boldSystemFont(ofSize: 24)
        return lb
    }()
    
    lazy var userImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFit
        iv.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 100, height: 100))
        return iv
    }()
    
    lazy var dimissButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 5
        btn.setTitle("Close", for: .normal)
        btn.tintColor = .green
        btn.backgroundColor = .systemBlue
        btn.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 160, height: 45))
        btn.addTarget(self, action: #selector(handleDimiss), for: .touchUpInside)
        return btn
    }()
    
    @objc func handleDimiss() {
        print("handleDimiss")
        
    }
    
    func setupView() {
        view.backgroundColor = .systemPink
        
        view.addSubview(userImage)
        userImage.centerInSuperview()
        
        view.addSubview(nameLabel)
        nameLabel.anchor(top: userImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 30, right: 0))
        nameLabel.centerXInSuperview()
        
        view.addSubview(dimissButton)
        dimissButton.anchor(top: nameLabel.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 30, right: 0))
        dimissButton.centerXInSuperview()
    }
    
    
    lazy var viewModel: UserViewModel = {
        return UserViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        viewModel.addObserve { (model) in
            model?.data?.info?.forEach({ (data) in
                self.nameLabel.text = data.user_nicename
                self.userImage.downloadImage(from: URL(string: data.avatar ?? "")!)
            })
        }
    }
}
