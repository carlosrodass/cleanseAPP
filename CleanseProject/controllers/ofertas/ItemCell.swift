import UIKit

class ItemCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellOfferLabel: UILabel!
    
    //Object
    func setData(with offer : Offer){
        cellImage.image = UIImage(named: offer.gsImage)
        cellLabel.text = offer.gsMarket
        cellOfferLabel.text = offer.gsOfferName
    }


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
