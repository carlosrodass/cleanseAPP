
import UIKit

class UserRegister: UIViewController {
    
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailRegister: UITextField!
    @IBOutlet weak var nameRegister: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enviarRegistro(_ sender: Any) {
        
        let username : String = nameRegister.text!
        let email : String = emailRegister.text!
        let pass : String = password.text!
        let confirmpassword : String = confirmPassword.text!
        let puntos : String = "0"
        
        
        //Comprobacion de campos
        if(username!.isEmpty || email!.isEmpty || pass!.isEmpty || confirmpassword!.isEmpty){
                   return
               }
        
        let parametros : [String: String] = [
                   "username": username,
                   "password": pass,
                   "email":email,
                   "password_confirmation":confirmpassword,
                   "points":puntos
               ]
        Request.shared.register(parameters: parametros).responseJSON{ response in
                
        debugPrint(response)
        }
        
    }
    
 }
