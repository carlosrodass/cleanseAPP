
import UIKit

class LoginUser: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func EnviarLogin(_ sender: Any) {
        
        
        //Comprobacion de campos
            sif(username!.isEmpty || email!.isEmpty || pass!.isEmpty || confirmpassword!.isEmpty){
                         return
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
}
