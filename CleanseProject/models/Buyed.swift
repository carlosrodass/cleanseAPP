//
//  Buyed.swift
//  CleanseProject
//
//  Created by user177278 on 3/11/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import Foundation

class Buyed: Encodable, Decodable{
     var _market: Int
     var _points: Int
    
    
    enum CodingKeys:String, CodingKey {
        case _market = "market"
        case _points = "points"
        
    }
    
    init(market:Int, points:Int){
        self._market = market
        self._points = points
    }
    
    public func getBuyedlist()->[String:Any]{
    
        return ["market":_market,"points":_points]
    
    }
    public func upBuyedserver()->[String:Any]{
        
        return ["market":_market,"points":_points]
    
    }
    


}
