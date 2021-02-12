import UIKit
import Lottie


struct Slide {
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String
    
    static let collection: [Slide] = [
        .init(title: "Bienvenido! conoce con nosotros un nuevo mundo  a la vez que cuidamos el medio ambiente", animationName: "people", buttonColor: .systemGreen, buttonTitle: "Siguiente"),
        
        .init(title: "Dejemos un legado bonito y sintamonoss orgullosos de ello, es el momento", animationName: "forest", buttonColor: .systemGreen, buttonTitle: "Siguiente"),
        
        .init(title: "Estas a punto de dar un paso muy importante en tu vida, ¿Te atreves? ", animationName: "people", buttonColor: .systemYellow, buttonTitle: "Comenzar")
    ]
}


class TutorialOneViewController: UIViewController{


    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    private let slides : [Slide] = Slide.collection

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
    }
    
    private func setUpCollectionView(){
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        myCollectionView.collectionViewLayout = layout
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        myCollectionView.contentInsetAdjustmentBehavior = .never
        myCollectionView.isPagingEnabled = true
    }
    
    private func handleActionButtonTap(at indexPath: IndexPath) {
        //Comprobando en que pantalla estas
        if(indexPath.item == slides.count - 1){
            
            goToRegister() //Cambiando de escena a la de sergio
            
        }else{
            let nextIndex = indexPath.item + 1
            let nextIndexPath = IndexPath(item: nextIndex, section: 0)
            myCollectionView.scrollToItem(at: nextIndexPath, at: .top, animated: true)
        }
    }
    
    
    private func goToRegister(){
        
        let InvitadoViewController = UIStoryboard(name: "Tutoria", bundle: nil).instantiateViewController(identifier: "bienvenidocleanse")
        
        if let sceneWindow = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = sceneWindow.delegate as? SceneDelegate,
           let window = sceneDelegate.window{
            window.rootViewController = InvitadoViewController
            UIView.transition(with: window,
                              duration: 0.25,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
}


extension TutorialOneViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)-> Int{
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)-> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! TutorialOneCollectionViewCell
        
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        
        //Boton presionado
        cell.actionButtonDidTap = { [weak self] in
            self?.handleActionButtonTap(at: indexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }

}


class TutorialOneCollectionViewCell: UICollectionViewCell{
    @IBOutlet weak var animationView : AnimationView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    
    var actionButtonDidTap: (() -> Void)?
    
    
    func configure(with slide: Slide){
        textLabel.text = slide.title
        actionButton.layer.cornerRadius = 10
        actionButton.clipsToBounds = true
        actionButton.backgroundColor = slide.buttonColor
        actionButton.setTitle(slide.buttonTitle, for: .normal)
        
        let animation = Animation.named(slide.animationName)
        
        animationView.animation = animation
        animationView.loopMode = .loop
        animationView.play()
    
    }
    
    @IBAction func actionButtonTapped(){
        actionButtonDidTap?()
    }
}
