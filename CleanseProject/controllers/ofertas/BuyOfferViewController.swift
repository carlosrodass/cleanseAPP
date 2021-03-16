import UIKit
import BLTNBoard

class BuyOfferViewController: UIViewController {
    
    @IBOutlet weak var imageOffer: UIImageView!
    @IBOutlet weak var labelOfferName: UILabel!
    @IBOutlet weak var labelOfferDes: UILabel!
    @IBOutlet weak var buyButtonStyle: UIButton!
    
    var offer: Offer?
    var sup: String = ""
    var of: String = ""
    var po: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButton()
        
        
//      imageOffer.image = offer?._image
        labelOfferName.text = offer?.gsMarket
        labelOfferDes.text = "Actualmente quedan \(offer!.gsStock) productos! ¿Quieres comprar ahora \(offer!.gsOfferName) del supermercado \(offer!.gsMarket)? costaria un total de \(offer!.gsPoints).Pulsa comprar y será tuyo!."
        
        sup = offer!.gsMarket
        of = offer!.gsOfferName
        po = offer!.gsPoints
            
    }
    
    
    private func roundButton(){
        //signIn button style
        buyButtonStyle.layer.cornerRadius = 10
        buyButtonStyle.clipsToBounds = true
    }
    
    @IBAction func buyButton(_ sender: Any) {
        
        ///Comprobacion previa de los puntos del usuario
       
        
        ///Request enviando nombre de la oferta / supermercado / puntos del usuario
        let parameters : [String:String] = [
            
            "offer_id" : String(offer!.gsOfferId), ///Offer id
            "market_name" : sup, ///Market name
            "offer_name" : of,///Offer name
            "points" : "15", ///User points || Preguntar ¿los guardo en userdefaults y los saco aqui?
            
        ]
        let request = Request.shared.BuyOffer(parameters: parameters)
        request.response(completionHandler: { (response) in

            guard let data = response.data else {return}
            do{
                debugPrint(data)
                ///case status code 200 ---
                ///case status code another
                ///La respuesta debe ser que se ha comprado y esta informacion debe mostrarse en la lista de compras
            }catch{
                print("estoy aqui")
            }
        })
    }
}

