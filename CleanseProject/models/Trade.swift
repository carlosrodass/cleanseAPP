//
//  Trade.swift
//  CleanseProject
//
//  Created by user176688 on 3/14/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import Foundation

class Trade{
    private var _trash:String
    private var _container_id: String
    
    
    enum CodingKeys:String, CodingKey {
        case _trash = "trash"
        case _container_id = "container_id"
        
        
    }
    
    init(trash: String, container_id:String){
        self._trash = trash
        self._container_id = container_id
        
    }
    
    var gsTrade:String{
        get{
            return self._trash
        }
        set(newTrash){
            self._trash = newTrash
        }
    }
    
    
    var gsID:String{
        get{
            return self._container_id
        }
        set(newContainer_id){
            self._container_id = newContainer_id
        }
    }
    
   

}
