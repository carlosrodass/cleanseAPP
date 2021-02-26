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
    

    @IBAction func applyChangesButton(_ sender: Any) {
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundImage()

        // Do any additional setup after loading the view.
    }
    
    
    private func roundImage(){
          //profile image style
          profileimage.layer.cornerRadius = profileimage.frame.size.width / 2
          profileimage.layer.borderColor = UIColor.white.cgColor
          profileimage.layer.borderWidth = 2
          profileimage.clipsToBounds = true
      }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
