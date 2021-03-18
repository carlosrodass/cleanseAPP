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
        imageView.image = UIImage(named: "buena")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    public func configure(){
        addSubview(imageView)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds

    }
        
}
