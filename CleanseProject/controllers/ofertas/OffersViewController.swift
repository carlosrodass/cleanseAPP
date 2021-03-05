
import UIKit

class OffersViewController: UIViewController {
    
    var oferta:Offer?
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
        
    let offers : [Offer] = [Offer.init(image: #imageLiteral(resourceName: "mm"), market: "Manzanas", offer: "Lidl"),
                            Offer.init(image: #imageLiteral(resourceName: "pp"), market: "Sal", offer: "Mercadona"),
                            Offer.init(image: #imageLiteral(resourceName: "cc"), market: "Albaricoque", offer: "Carrefour"),
                            Offer.init(image: #imageLiteral(resourceName: "aa"), market: "Aguacate", offer: "Eroski"),
                            Offer.init(image: #imageLiteral(resourceName: "mm"), market: "Manzanas", offer: "Carrefour"),
                            Offer.init(image: #imageLiteral(resourceName: "cc"), market: "Cereza", offer: "Mercadona"),
                            Offer.init(image: #imageLiteral(resourceName: "pp"), market: "Platano", offer: "Lidl"),
                            Offer.init(image: #imageLiteral(resourceName: "aa"), market: "Aguacate", offer: "Eroski"),
                            Offer.init(image: #imageLiteral(resourceName: "mm"), market: "Manzanas", offer: "Lidl")]
    
 

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
    
    //Añadiendo datos en cada una de las celdas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.setData(with: offers[indexPath.row])
        
///        cell.setArr(imagen: self.offerImage[indexPath.row], market: self.offerMarket[indexPath.row], offer: self.offerName[indexPath.row])
        
        cell.setupCell()
        
        return cell
    }
}

//Forma visual de las celdas, alto, ancho, padding
extension OffersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.frame.width / 3) - 20, height: 160)
    }
}

//Accion de cada elemento de la lista
extension OffersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "detail" {
            let vc = segue.destination as! BuyOfferViewController
            let cell = sender as! ItemCell
            let indexPath = MyCollectionView.indexPath(for: cell)
            let offer = offers[indexPath!.row]
            vc.offer = offer.self
            
            print("Objeto:  \(vc.offer = offer)")
            present(vc, animated: true)
        }
    }
    
 
}
