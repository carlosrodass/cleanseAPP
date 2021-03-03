//
//  Offer.swift
//  CleanseProject
//
//  Created by user177278 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//
import UIKit

import Foundation

class Offer{
    
    public var _image:UIImage
    public var _market: String
    public var _offer:String

    init(image:UIImage, market:String,  offer:String){
        
        self._image = image
        self._market = market
        self._offer = offer
    
    }
}
