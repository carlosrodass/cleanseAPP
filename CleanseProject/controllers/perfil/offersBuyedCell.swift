//
//  offersBuyedCell.swift
//  CleanseProject
//
//  Created by user177278 on 3/11/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

class offersBuyedCell: UITableViewCell {

    @IBOutlet weak var cellMarketLabel: UILabel!
    @IBOutlet weak var cellPointsLabel: UILabel!
    
//    //Object
//    func setData(with buyed : Buyed){
//        cellImage.image = UIImage(named: buyed.gsImage)
//        cellMarketLabel.text = buyed.gsMarket
//        cellPointsLabel.text = String(buyed.gsPoints)
//    }
    
   public func setupCell() {
            
            roundCorner()
            setCellShadow()
        }
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = false
        self.layer.shadowPath = UIBezierPath(
        roundedRect: self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
    }

    func roundCorner() {
        self.contentView.layer.cornerRadius = 12.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
            
            
    }
}
