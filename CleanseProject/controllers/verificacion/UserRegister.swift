
import UIKit

class UserRegister: UIViewController {
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var nameRegister: UITextField!
    @IBOutlet weak var enviarRegistroOulet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundButton()
    }
    
    @IBAction func enviarRegistro(_ sender: Any) {
        
        let username : String = nameRegister.text!
        let email : String = emailRegister.text!
        let pass : String = password.text!
        let confirmpassword : String = confirmPassword.text!
       
        
        
        //Comprobacion de campos
        if(username.isEmpty || email.isEmpty || pass.isEmpty || confirmpassword.isEmpty){
            
            let alert = UIAlertController(title: "fields empty ", message: "Some field is empty", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                print("presionado")
            }))
            
            present(alert, animated: true)

               }
        
        let parametros : [String: String] = [
                   "username": username,
                   "password": pass,
                   "email":email,
                   "password_confirmation":confirmpassword
                 
               ]
        Request.shared.register(parameters: parametros).responseJSON{ response in
                
        debugPrint(response)
        }
        
    }
    
    private func roundButton(){
        //signIn button style
        enviarRegistroOulet.layer.cornerRadius = 10
        enviarRegistroOulet.clipsToBounds = true
    }
    
 }
