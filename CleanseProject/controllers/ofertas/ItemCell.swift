//
//  ItemCell.swift
//  CleanseProject
//
//  Created by user177278 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellOfferLabel: UILabel!
    
    //Object
    func setData(with offer : Offer){
        cellImage.image = offer._image
        cellLabel.text = offer._market
        cellOfferLabel.text = offer._offer
    }
    
    //Arrays
    func setArr(imagen : UIImage, market : String, offer : String){
        cellImage.image = imagen
        self.cellLabel.text = market
        self.cellOfferLabel.text = offer
        
    }
    
        // MARK: Setup Cell
    public func setupCell() {
            
            roundCorner()
            setCellShadow()
        }
        
        // MARK: Methods
        func setCellShadow() {
            self.layer.shadowColor = UIColor.white.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 1)
            self.layer.shadowOpacity = 1.0
            self.layer.shadowRadius = 1.0
            self.layer.masksToBounds = false
            self.layer.cornerRadius = 12.0
            self.clipsToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        }

        func roundCorner() {
            self.contentView.layer.cornerRadius = 12.0
            self.contentView.layer.masksToBounds = true
            self.contentView.layer.borderWidth = 1.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            
            
        }
        
    }
