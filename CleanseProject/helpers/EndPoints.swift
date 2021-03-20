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
    
    let baseURL = "http://54.90.104.81/api/"
    
    ///verificacion
    let login:String = "login"
    let register:String = "register"
    ///Perfil
    let getProfile:String = "users/profile"
    let updateProfile:String = "users/update"
    let logOut:String = "users/logout"
    ///Ofertas
    let buyOffer:String = "offers/trade"
    let getOffers:String = "offers/all"
    ///contenedores
    let trade:String = "containers/trade"
    let getContainers:String = "containers/all"
    let containerByName:String = "containers/show"
    ///Ofertas compradas
    let buyedOffers:String = "buyed/show"
   

 
    
    
    
    
    
}
