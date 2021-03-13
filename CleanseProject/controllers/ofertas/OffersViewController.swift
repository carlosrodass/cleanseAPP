
import UIKit

class OffersViewController: UIViewController {
        
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    var offers : [Offer] = []
        
//        [Offer.init(image: "ff", offer: "salchichas", market: "lidl", points: 20, stock: 20, offerId: 2),
//                            Offer.init(image: "ff", offer: "chocolate", market: "marcadona", points: 15, stock: 48, offerId: 1)]

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
        ///Request
        let request = Request.shared.getOffers()
         request.response(completionHandler: { (response) in

             guard let data = response.data else {return}
             do{
    
                //Rellenar el array de ofertas con el array de json que viene del servidor
                self.offers = try
                    JSONDecoder().decode([Offer].self, from: data) //Da error porque la resp del serv es dictionary
                
                self.MyCollectionView.reloadData()
                print(self.offers)
                
             }catch{
                 print("estoy aqui == \(error)")
             }
         })
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

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
        return offers.count
    }
    
    ///Añadiendo datos en cada una de las celdas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell

        cell.setData(with: offers[indexPath.row])
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
//            let ofertas = fillOffer()
            let offer = offers[indexPath!.row]
            vc.offer = offer.self
            
//            print("Objeto:  \(vc.offer = offer)")
            present(vc, animated: true)
        }
    }
    
 
}
