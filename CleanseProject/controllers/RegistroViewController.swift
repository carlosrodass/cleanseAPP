
import UIKit

class RegistroViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        registerRequest()
    }
    
    public func registerRequest (){
        
        //Variables
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        let confirmpassword = confirmPasswordField.text
        
        //Comprobacion de campos
        
        if(username!.isEmpty || email!.isEmpty || password!.isEmpty || confirmpassword!.isEmpty){
            return
        }
    }

}
