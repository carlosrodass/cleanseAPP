import UIKit

class BuyOfferViewController: UIViewController {
    
    @IBOutlet weak var imageOffer: UIImageView!
    @IBOutlet weak var labelOfferName: UILabel!
    @IBOutlet weak var labelOfferDes: UILabel!
    
    var offer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      imageOffer.image = offer?._image
        labelOfferName.text = offer?._market
        labelOfferDes.text = "It is a long established fact \(offer!._offer) that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that  opposed to using 'Content here, content here',\(offer!._offer)"
            
    }
    
    @IBAction func buyButton(_ sender: Any) {
            ///Request
//
//        let parameters : [String:String] = [
//
//
//        ]
//        let request = Request.shared.BuyOffer(parameters: parameters)
//            request.response(completionHandler: { (response) in
//                guard let data = response.data else {return}
//                    do{
//                        debugPrint(response)
//                    }catch{
//                        print("estoy aqui")
//                    }
//                })
                
    }
    
}



//                        self.dataUser = try JSONDecoder().decode(Userr.self, from: data)
//                        print(self.dataUser?.username)
//                        self.userNameProfile.text = self.dataUser?.username
//                        self.pointsProfile.text = self.dataUser?.puntos
