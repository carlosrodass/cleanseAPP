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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func setData(textMarket: String,textOffer: String , image : UIImage){
        self.cellLabel.text = textMarket
        self.cellOfferLabel.text = textOffer
        cellImage.image = image
    }

}
