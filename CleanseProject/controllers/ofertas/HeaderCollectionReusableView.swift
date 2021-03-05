//
//  HeaderCollectionReusableView.swift
//  CleanseProject
//
//  Created by user177278 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit
import Foundation

class HeaderCollectionReusableView: UICollectionReusableView {
    
    static let indentifier = "HeaderCollectionReusableView"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "incre")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
//    let labelName: UILabel = {
//        let label = UILabel()
//        label.text = "Your points: 35 points"
//        label.textColor = UIColor.white
//        label.font = UIFont.boldSystemFont(ofSize: 19)
//        label.textAlignment = .left
//        return label
//    }()
    
    

   
    public func configure(){
        addSubview(imageView)
//        addSubview(labelName)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
//        labelName.frame = bounds
    }
        
}
