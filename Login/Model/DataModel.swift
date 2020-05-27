//
//  DataModel.swift
//  Login
//
//  Created by ting on 2020/5/26.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

struct Datas: Codable {
    let code: Int?
    let msg: String?
    let info: [Info]?
}
