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
        imageView.image = UIImage(named: "findway")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
//    let labelName: UILabel = {
//        let label = UILabel()
//        label.text = "List"
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