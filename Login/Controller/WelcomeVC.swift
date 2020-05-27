//
//  WelcomeVC.swift
//  Login
//
//  Created by kiras on 2020/5/26.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {
    
    lazy var label: UILabel = {
        let lb = UILabel()
        lb.text = "Welcome"
        lb.backgroundColor = .systemPink
        lb.textAlignment = .center
        lb.font = .boldSystemFont(ofSize: 24)
        return lb
    }()
    
    let userImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .yellow
        iv.layer.cornerRadius = 10
        iv.contentMode = .scaleAspectFit
        iv.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: .init(width: 100, height: 100))
        return iv
    }()
    
    //var model: Base?
    var infoAvatar: String?
    
    //    init(data: Base) {
    //        super.init(nibName: nil, bundle: nil)
    //        self.model = data
    //    }
    //
    //    required init?(coder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        view.addSubview(userImage)
        userImage.centerInSuperview()
        
        view.addSubview(label)
        label.anchor(top: userImage.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 40, left: 0, bottom: 30, right: 0))
        label.centerXInSuperview()

    }
}
