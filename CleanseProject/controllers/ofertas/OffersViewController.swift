
import UIKit

class OffersViewController: UIViewController {
        
    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    var offers : [Offer] = []
    var imagenes : [UIImage] = [#imageLiteral(resourceName: "aa"), #imageLiteral(resourceName: "ff")]


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
        ///offers request
        let request = Request.shared.getOffers()
        request.responseJSON { (response) in
            if let body = response.value as? [[String:Any]]{
                for i in 0..<body.count{
                    self.offers.append(Offer(offer: body[i]["Offer"] as! String, market: body[i]["Market"] as! String, points: body[i]["Points"] as! Int, stock: body[i]["Stock"] as! Int, offerId: body[i]["id"] as! Int))
                }
                print(self.offers)
                self.MyCollectionView.reloadData()
            }
        }
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
        
        cell.cellOfferLabel.text = offers[indexPath.row].gsOfferName
        cell.cellLabel.text = offers[indexPath.row].gsMarket
        cell.cellImage.image = imagenes[indexPath.row]
        
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

            vc.labelOfferName.text = String(offers[indexPath!.row].gsOfferName)
            vc.labelOfferDes.text = String(offers[indexPath!.row].gsMarket)

            present(vc, animated: true)
        }
    }
    
 
}
