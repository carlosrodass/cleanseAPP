
import UIKit

class OffersViewController: UIViewController {

    @IBOutlet weak var MyCollectionView: UICollectionView!
    
    let dataMarketArray = ["Ldl", "Corte ingles", "Mercadona","Ldl", "Corte ingles", "Mercadona","Ldl", "Corte ingles", "Mercadona"]
    let dataOfferArray = [ "Manzanas", "Peras", "Lubina", "Algodon", "Miel", "Manzanas", "Peras", "Lubina", "Algodon"]
    let dataImageArray: Array<UIImage> = [#imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo"), #imageLiteral(resourceName: "lidl-logo")]
    
//    var Width = 160.0
//    var cellMarginSize = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates
        self.MyCollectionView.delegate = self
        self.MyCollectionView.dataSource = self
        self.MyCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        //Register cells
//        self.MyCollectionView.register(UINib(nibName: "ItemCell", bundle: nil), forCellWithReuseIdentifier: "ItemCell")
        
        //setUpGrid view
//        self.setUpGridView()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
//        self.setUpGridView()
//        DispatchQueue.main.async {
//            self.MyCollectionView.reloadData()
//        }
    }
//
//    func setUpGridView(){
//        let flow = MyCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        flow.minimumInteritemSpacing = CGFloat(self.cellMarginSize)
//        flow.minimumLineSpacing = CGFloat(self.cellMarginSize)
//
//
//    }
}

//Rellenando las celdas de datos
extension OffersViewController: UICollectionViewDataSource{
    
    //Numero de celdas a mostrar
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataMarketArray.count
    }
    
    //Añadiendo datos en cada una de las celdas
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = MyCollectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        //Aqui en setData cambiar por el objeto oferta para recibir los datos de la API
        cell.setData(textMarket: self.dataMarketArray[indexPath.row], textOffer: self.dataOfferArray[indexPath.row], image: self.dataImageArray[indexPath.row])
        
        return cell
    }
}

//Forma visual de las celdas, alto, ancho, padding
extension OffersViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let Width = self.calculateWith()
        return CGSize(width: 200, height: 300)
    }
//
//    func calculateWith() -> CGFloat{
//        let estimateWidth = CGFloat(Width)
//        let cellCout = floor(CGFloat(self.view.frame.size.width / estimateWidth))
//
//        let margin = CGFloat(cellMarginSize * 2)
//        let width = (self.view.frame.size.width - CGFloat(cellMarginSize) * (cellCout - 1) - margin) / cellCout
//
//        return width
//     }
}


//Accion de cada elemento de la lista
extension OffersViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}


