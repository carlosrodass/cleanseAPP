import UIKit

class BuyOfferViewController: UIViewController {
    
    @IBOutlet weak var imageOffer: UIImageView!
    @IBOutlet weak var labelOfferName: UILabel!
    @IBOutlet weak var labelOfferDes: UILabel!
    @IBOutlet weak var buyButtonStyle: UIButton!
    
    var offer: Offer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButton()
        
//      imageOffer.image = offer?._image
        labelOfferName.text = offer?.gsMarket
        labelOfferDes.text = "Cantidad disponible de la oferta : \(offer!.gsStock) La oferta que has elegido del supermercado \(offer!.gsOfferName) costaria un total de \(offer!.gsPoints). Para conjear esta oferta pulsa el boton de comprar y enseña el código de la oferta en el supermercado marcado."
            
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

            "user_id" : "userToken", ///User Id
            "offer_id" : String(offer!.gsOfferId), ///Offer id
            "market_name" : offer!.gsMarket, ///Market name
            "offer_name" : offer!.gsOfferName,///Offer name
            "user_points" : "Aqui mandar ptos del usuario", ///User points || Preguntar ¿los guardo en userdefaults y los saco aqui?
            
        ]


        let request = Request.shared.BuyOffer(parameters: parameters)
        request.response(completionHandler: { (response) in

            guard let data = response.data else {return}
            do{
                debugPrint(data) ///La respuesta debe ser que se ha comprado y esta informacion debe mostrarse en la lista de compras
            }catch{
                print("estoy aqui")
            }
        })
                
    }
    
}



//                        self.dataUser = try JSONDecoder().decode(Userr.self, from: data)
//                        print(self.dataUser?.username)
//                        self.userNameProfile.text = self.dataUser?.username
//                        self.pointsProfile.text = self.dataUser?.puntos
