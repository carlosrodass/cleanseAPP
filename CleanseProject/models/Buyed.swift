//
//  Buyed.swift
//  CleanseProject
//
//  Created by user177278 on 3/11/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import Foundation

class Buyed{
    private var _image:String
    private var _market: String
    private var _points: Int
    
    
    enum CodingKeys:String, CodingKey {
        case _image = "image"
        case _market = "market"
        case _points = "points"
        
    }
    
    init(image: String, market:String, points:Int){
        self._image = image
        self._market = market
        self._points = points
    }
    
    var gsImage:String{
        get{
            return self._image
        }
        set(newImage){
            self._image = newImage
        }
    }
    
    
    var gsMarket:String{
        get{
            return self._market
        }
        set(newMarket){
            self._market = newMarket
        }
    }
    
    var gsPoints:Int{
        get{
            return self._points
        }
        set(newPoints){
            self._points = newPoints
        }
    }

}
