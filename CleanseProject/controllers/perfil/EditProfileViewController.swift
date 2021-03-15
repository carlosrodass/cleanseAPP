//
//  EditProfileViewController.swift
//  CleanseProject
//
//  Created by user177278 on 2/16/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    @IBOutlet weak var changeUserNameField: UITextField!
    @IBOutlet weak var changeEmailField: UITextField!
    @IBOutlet weak var changePassField: UITextField!
    @IBOutlet weak var profileimage: UIImageView!
    
    @IBOutlet weak var changeConfirmPasswor: UITextField!
    
    @IBAction func applyChangesButton(_ sender: Any) {
        
    
        let changeUsername : String = changeUserNameField.text!
        let changeemail : String = changeEmailField.text!
        let changePassword : String = changePassField.text!
        let changeConfirmPass : String = changeConfirmPasswor.text!
        let parametros : [String: String] = [
            
            
            "username" : changeUsername,
            "email" : changeemail,
            "password" : changePassword,
            "password_confirmation" : changeConfirmPass
                   
               ]

        Request.shared.updateProfile(parameters: parametros).responseJSON{response in
            debugPrint(response)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundImage()
    }
    
    
    private func roundImage(){
          //profile image style
          profileimage.layer.cornerRadius = profileimage.frame.size.width / 2
          profileimage.layer.borderColor = UIColor.white.cgColor
          profileimage.layer.borderWidth = 2
          profileimage.clipsToBounds = true
      }
    

}
