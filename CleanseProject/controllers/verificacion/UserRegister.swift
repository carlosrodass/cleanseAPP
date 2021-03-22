
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
        
        if(confirmpassword.description == pass.description){
        let parametros : [String: String] = [
                   "username": username,
                   "password": pass,
                   "email":email,
                   "password_confirmation":confirmpassword
                 
               ]
        Request.shared.register(parameters: parametros)
            .validate(statusCode: 200..<300)
            .responseJSON{ response in
                
        debugPrint(response)
            
            switch response.result {
               
            case .success:
                
               let alertacept = UIAlertController(title: "ok", message: "Usuario creado", preferredStyle: .alert)
  
               let OKAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(_)in
               self.performSegue(withIdentifier: "irlogin", sender: self)
    })

               alertacept.addAction(OKAction)
               self.present(alertacept, animated: true, completion: nil)
             
            case let .failure(error):
                
                let alerterror = UIAlertController(title: "Algo salió mal", message: "Email no valido debe rellenar el campo", preferredStyle: .alert)
               

                alerterror.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alerterror, animated: true, completion: nil)
                print(error)
            }

            }
            
        }else{
            
            let alertpass = UIAlertController(title: " algo salio mal ", message: "las contraseñas no coinciden", preferredStyle: .alert)
            alertpass.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                print("presionado")
            }))
            
            present(alertpass, animated: true)
            
        }
        
    }
    
    private func roundButton(){
        //signIn button style
        enviarRegistroOulet.layer.cornerRadius = 10
        enviarRegistroOulet.clipsToBounds = true
    }
    
 }
