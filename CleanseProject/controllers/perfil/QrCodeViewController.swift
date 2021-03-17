//
//  QrCodeViewController.swift
//  CleanseProject
//
//  Created by user177278 on 3/17/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

class QrCodeViewController: UIViewController {

    var buyed: Buyed?

    @IBOutlet weak var offerQrName: UILabel!
    @IBOutlet weak var imageQr: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting texton screen
        offerQrName.text = buyed!._market
        
        if let myString = offerQrName.text{
            imageQr.image = generateQRCode(from: myString)
        }else{
            imageQr.image = generateQRCode(from: "Carlos is the best programmer ever")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 10, y: 10)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
    

}
