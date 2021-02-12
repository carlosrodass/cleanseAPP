//
//  EntrarCuenta.swift
//  CleanseProject
//
//  Created by user176688 on 2/1/21.
//  Copyright © 2021 user176688. All rights reserved.
//
import Alamofire
import UIKit

class EntrarCuenta: UIViewController {



    
    @IBOutlet weak var email: UITextField!
    
  

    
    @IBOutlet weak var password: UITextField!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        
    }

    
    
    class User:Decodable{
        var  email : String
        var password : String
        
        
    }
    
    

    //}
    
    private func mostrarAlerta(mensaje: String){
        let alerta = UIAlertController(title:"my userdefault", message: mensaje, preferredStyle: .alert)
        alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alerta, animated: true, completion: nil)
        
    }
    
}
