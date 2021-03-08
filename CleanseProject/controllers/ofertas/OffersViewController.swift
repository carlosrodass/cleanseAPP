
import UIKit

class OffersViewController: UIViewController {
        
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    
//    let offers : [Offer] = [Offer.init(image: #imageLiteral(resourceName: "mm"), offer: "Lidl", market: "Manzanas",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "pp"), offer: "Mercadona", market: "Sal",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "cc"), offer: "Carrefour", market: "Albaricoque",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "aa"), offer: "Eroski", market: "Aguacate",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "mm"), offer: "Carrefour", market: "Manzanas",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "cc"), offer: "Mercadona", market: "Cereza",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "pp"), offer: "Lidl", market: "Platano",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "aa"), offer: "Eroski", market: "Aguacate",points: 10, stock: 5),
//                            Offer.init(image: #imageLiteral(resourceName: "mm"), offer: "Lidl", market: "Manzanas",points: 10, stock: 5)]
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ///set delegates
        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
        
        ///Margins
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        MyCollectionView!.collectionViewLayout = layout
        
        ///register
        self.MyCollectionView?.register(HeaderCollectionReusableView.self,
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.indentifier)
        
//        offerRequest()
        fillOffer() ///Desde aqui se inicializa la peticion
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    
    func fillOffer()->Array<Offer>{
        ///Request y rellenar el array con los datos de la request
//        let userToken:String = UserDefaults.standard.string(forKey: "token")!
//        print("token guardado \(userToken)")
//
//        let parameters : [String:String] = [
//
//            "token" : userToken
//        ]
//
//
//        let request = Request.shared.getOffers(parameters: parameters)
//        print(userToken)
//        request.response(completionHandler: { (response) in
//
//            guard let data = response.data else {return}
//            do{
////                self.dataUser = try JSONDecoder().decode(Userr.self, from: data)
////                print(self.dataUser?.username)
////                self.userNameProfile.text = self.dataUser?.username
////                self.pointsProfile.text = self.dataUser?.puntos
//                debugPrint(data)
//            }catch{
//                print("estoy aqui")
//            }
//        })
        
        let offers : [Offer] = [Offer.init(image: #imageLiteral(resourceName: "mm"), offer: "Lidl", market: "Manzanas",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "pp"), offer: "Mercadona", market: "Sal",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "cc"), offer: "Carrefour", market: "Albaricoque",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "aa"), offer: "Eroski", market: "Aguacate",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "mm"), offer: "Carrefour", market: "Manzanas",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "cc"), offer: "Mercadona", market: "Cereza",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "pp"), offer: "Lidl", market: "Platano",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "aa"), offer: "Eroski", market: "Aguacate",points: 10, stock: 5),
                                Offer.init(image: #imageLiteral(resourceName: "mm"), offer: "Lidl", market: "Manzanas",points: 10, stock: 5)]
        return offers
    }
    
    ///Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = MyCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.indentifier, for: indexPath) as! HeaderCollectionReusableView
        
        header.configure()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }
}

///Rellenando las celdas de datos
extension OffersViewController: UICollectionViewDataSource{
    
    ///Numero de celdas a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let ofertas = fillOffer()
        return ofertas.count
    }
    
    ///Añadiendo datos en cada una de las celdas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        let ofertas = fillOffer()
        cell.setData(with: ofertas[indexPath.row])
        
///        cell.setArr(imagen: self.offerImage[indexPath.row], market: self.offerMarket[indexPath.row], offer: self.offerName[indexPath.row])
        
        cell.setupCell()
        
        return cell
    }
}

///Forma visual de las celdas, alto, ancho, padding
extension OffersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.frame.width / 3) - 20, height: 160)
    }
}

///Highligth de cada elemento de la lista
extension OffersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
///Segue pasando datos entre controllers
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "detail" {
            let vc = segue.destination as! BuyOfferViewController
            let cell = sender as! ItemCell
            let indexPath = MyCollectionView.indexPath(for: cell)
            let ofertas = fillOffer()
            let offer = ofertas[indexPath!.row]
            vc.offer = offer.self
            
            print("Objeto:  \(vc.offer = offer)")
            present(vc, animated: true)
        }
    }
    
 
}
