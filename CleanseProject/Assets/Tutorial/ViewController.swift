



import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        goToRTutorial()
    }

    private func goToRTutorial(){
        
        let InvitadoViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "TutorialViewController")
        
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

