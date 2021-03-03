//
//  Extensions.swift
//  CleanseProject
//
//  Created by user176688 on 3/2/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

extension UIView{
    
    func addConstrainsToFillView(view: UIView){
        self.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddignLeft: 0, paddingBotom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddignLeft: CGFloat, paddingBotom: CGFloat,paddingRight: CGFloat, width: CGFloat, height: CGFloat){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top{
            
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
            
            
        }
        if let left = left{
            
            self.leftAnchor.constraint(equalTo: left, constant: paddignLeft).isActive = true
            
            
        }
        if let bottom = bottom{
            
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBotom).isActive = true
            
            
        }
        if let rigth = right{
            
            rightAnchor.constraint(equalTo: rigth, constant: -paddingRight).isActive = true
            
            
        }
        if width != 0{
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
            
        }
        if height != 0{
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
            
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
}
