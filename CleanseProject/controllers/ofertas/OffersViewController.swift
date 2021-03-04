
import UIKit

class OffersViewController: UIViewController {
    
    var oferta:Offer?
    
    @IBOutlet weak var MyCollectionView: UICollectionView!
        
    let offers : [Offer] = [Offer.init(image: #imageLiteral(resourceName: "fresa"), market: "Lidl", offer: "Fresas"),
                            Offer.init(image: #imageLiteral(resourceName: "sal"), market: "Mercadona", offer: "Sal"),
                            Offer.init(image: #imageLiteral(resourceName: "alba"), market: "Carrefour", offer: "Albaricoque"),
                            Offer.init(image: #imageLiteral(resourceName: "tomate"), market: "Eroski", offer: "Tomate")]
                            

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
        
        //Margins
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        MyCollectionView!.collectionViewLayout = layout
        
        //register
        self.MyCollectionView?.register(HeaderCollectionReusableView.self,
                                       forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.indentifier)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    //Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = MyCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.indentifier, for: indexPath) as! HeaderCollectionReusableView
        
        header.configure()
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 200)
    }

}

//Rellenando las celdas de datos
extension OffersViewController: UICollectionViewDataSource{
    
    //Numero de celdas a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return offers.count
    }
    
    //Añadiendo datos en cada una de las celdas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        cell.setData(with: offers[indexPath.row])
        
        cell.setupCell()
        
        return cell
    }
}

//Forma visual de las celdas, alto, ancho, padding
extension OffersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (view.frame.width / 2) - 20, height: 95)
    }
}

//Accion de cada elemento de la lista
extension OffersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let vc = BuyOfferViewController()
        
        print(indexPath.row)
    }
}





