//
//  BuyOfferViewController.swift
//  CleanseProject
//
//  Created by user177278 on 3/3/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

class BuyOfferViewController: UIViewController {
    
    @IBOutlet weak var imageOffer: UIImageView!
    @IBOutlet weak var labelOfferName: UILabel!
    @IBOutlet weak var labelOfferDes: UILabel!
    
    var image : UIImage = #imageLiteral(resourceName: "download")
    var name : String = ""
    var desc : String = ""
    //recibir ptos necesarios
//    
//    var offer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageOffer.image = image
        labelOfferName.text = "Your offer name is \(name)"
        labelOfferDes.text = "It is a long established fact \(desc) that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here',\(desc)"
//
//        offer?._image = imageOffer.image!
//        offer?._market = "description"
//        offer?._offer = labelOfferDes.text!
        
       
    }
    
    @IBAction func buyButton(_ sender: Any) {
        //Enviar el nombre de la OFERTA + SUPERMERCADO + PTOS DEL USUARIO
        
        //COMPROBACION LOCAL DE PUNTOS NECESARIOS
        //--ENVIAR
        
    }
    
}
