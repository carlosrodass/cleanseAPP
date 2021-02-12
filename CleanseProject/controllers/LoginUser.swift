//
//  LoginUser.swift
//  CleanseProject
//
//  Created by user176688 on 2/10/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

class LoginUser: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func EnviarLogin(_ sender: Any) {
        
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
