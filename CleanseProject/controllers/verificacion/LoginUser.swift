
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
        
        let alerterror = UIAlertController(title: "Algo salió mal", message: "Email o contraseña no valido vuelve a intentarlo", preferredStyle: .alert)
               let alertacept = UIAlertController(title: "ok", message: "Usuario y contraseña correcto", preferredStyle: .alert)
        let emailField = email.text
        let pass = password.text
        
        //Comprobacion de campo
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
        
        Request.shared.login(parameters: parametros)
            .validate(statusCode: 200..<300)
                .responseJSON{ response in
                
         
                
                    switch response.result {
                       
                    case .success:
                        
                        let token = response.value as! [String:String]//accediendo al valor token: "94290rsewqrw"

                        UserDefaults.standard.set(token["Token"], forKey: "Token")

                        debugPrint(UserDefaults.standard.set(token["Token"], forKey: "Token"))

                       
                        self.performSegue(withIdentifier: "irmapa", sender: nil)
          
              
                     
                    case let .failure(error):
                       

                        alerterror.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                        self.present(alerterror, animated: true, completion: nil)
                        print(error)
                    }
               
                
        }
   }
    
    private func roundButton(){
        //signIn button style
        enviarLoginOulet.layer.cornerRadius = 10
        enviarLoginOulet.clipsToBounds = true
    }
}
