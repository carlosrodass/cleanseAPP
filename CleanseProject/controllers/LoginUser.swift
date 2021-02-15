
import UIKit

class LoginUser: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var enviarLoginOulet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        roundButton()

    }
    
    @IBAction func EnviarLogin(_ sender: Any) {
        
        let emailField = email.text
        let pass = password.text
        
        //Comprobacion de campos
        if(emailField!.isEmpty || pass!.isEmpty){
            
            let alert = UIAlertController(title: "fields empty ", message: "Some field is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                print("presionado")
            }))
            
            present(alert, animated: true)
                     }
        
        let parametros : [String: String] = [
            
            "email": email.text!,
            "password": password.text!,
                
        ]
        print(parametros)
        Request.shared.login(parameters: parametros).responseJSON{ response in
            
        debugPrint(response)
    }

   }
    
    private func roundButton(){
        //signIn button style
        enviarLoginOulet.layer.cornerRadius = 10
        enviarLoginOulet.clipsToBounds = true
    }
}
