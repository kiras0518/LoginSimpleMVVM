//
//  UserViewModel.swift
//  Login
//
//  Created by ting on 2020/5/26.
//  Copyright © 2020 ameyo. All rights reserved.
//

import UIKit

protocol ViewModelable {
    associatedtype Model
    func addObserve(completion: @escaping (Model?) -> Void)
    func removeObserve()
}

class UserViewModel {
    let service: NetworkManager
    var completion: ((Base?) -> Void)?
    var showAlertClosure: (() -> ())?
    
    var model: Base? {
        didSet {
            completion?(model)
        }
    }
    
    var error: Error? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    init(service: NetworkManager = NetworkManager.shared) {
        self.service = service
    }
    
    func login(login: Login) {
        NetworkManager.shared.requestFetch(userInfo: login) { (result) in
            switch result {
            case .success(let model):
                self.model = model
            case .failure(let err):
                self.error = err
            }
        }
    }
}

// MARK: - ViewModelable
extension UserViewModel: ViewModelable {
    typealias Model = Base
    func addObserve(completion: @escaping (Base?) -> Void) {
        self.completion = completion
    }
    func removeObserve() {
        self.completion = nil
    }
}
