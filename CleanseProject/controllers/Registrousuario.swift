
import UIKit
import Alamofire

let request = Request()

class Registrousuario: UIViewController {

    @IBOutlet weak var Nombreregistro: UITextField!
    
    @IBOutlet weak var contrasenaregistro: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = UserDefaults.standard.string(forKey: "name") {
            Nombreregistro.text = name
    }
  
    }
    

    @IBAction func EnviarRegistro(_ sender: Any) {
  
        let user : String = Nombreregistro.text!
        let pass : String = contrasenaregistro.text!
        
        
        request.PostUsers(user: user, pass: pass)
        
        let name = Nombreregistro.text!
        UserDefaults.standard.set(name, forKey: "name")
        
       
    
        // if let valoremail = UserDefaults.standard.string(forKey: "name"){
        //    mostrarAlerta(mensaje:valoremail)
        
            
          
        // }else{
          
        // mostrarAlerta(mensaje: "no hay ningun valor")
          
        // }

      
    }
    

    
    private func mostrarAlerta(mensaje: String){
        let alerta = UIAlertController(title:"Atención", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alerta, animated: true, completion: nil)
        
    }
 
    }
    




