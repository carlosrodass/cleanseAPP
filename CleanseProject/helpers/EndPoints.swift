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
    
    let baseURL = "http://100.26.59.63/api/"
    
    ///verificacion
    let login:String = "login"
    let register:String = "register"
    ///Perfil
    let getProfile:String = "users/profile"
    let updateProfile:String = "users/update/{id}"
    ///Ofertas
    let buyOffer:String = "offers/trade"
    let getOffers:String = "offers/all"
    ///contenedores
    let trade:String = "containers/show/{userId}/{containerId}"
    let allContainers:String = "containers/all"
    let oneContainer:String = "containers/show/{street_name}"
    ///Ofertas compradas
    let buyedOffers:String = "buyed/all/{id}"
   

 
    
    
    
    
    
}
