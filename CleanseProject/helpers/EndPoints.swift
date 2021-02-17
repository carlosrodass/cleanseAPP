//
//  EndPoints.swift
//  CleanseProject
//
//  Created by user176688 on 2/10/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import Foundation
class Endpoints {
    
    private init() {}
    static let shared = Endpoints()
    
    let baseURL = "http://localhost:8888/API-cleanse/public/api/"
    let login:String = "login"
    let register:String = "register"
    let getProfile:String = "user"
    
    
    
    
    
}
