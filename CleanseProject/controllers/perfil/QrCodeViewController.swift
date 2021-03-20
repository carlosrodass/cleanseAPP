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
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var offerQR: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let username : String = UserDefaults.standard.string(forKey: "username")!
        
        //Setting texton screen
        offerQrName.text = "Hi,\(username)!"
        offerQR.text = "Scan this code to buy \(buyed!._market)"
        imageQr.image = generateQRCode(from: "https://www.youtube.com/watch?v=pK060iUFWXg")
        
        //ButtonStyle
        roundButton()
        
//        if let myString = offerQrName.text{
//
//        }else{
//            imageQr.image = generateQRCode(from: "Carlos is the best programmer ever")
//        }
    }
    
    private func roundButton(){
        //signIn button style
        doneButton.layer.cornerRadius = 10
        doneButton.clipsToBounds = true
    }
    
    
    @IBAction func donButtonAction(_ sender: Any) {
        
        self.dismiss(animated: true)
        
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
