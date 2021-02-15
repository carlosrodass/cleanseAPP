//
//  BienvenidoCleanse.swift
//  CleanseProject
//
//  Created by user176688 on 2/1/21.
//  Copyright © 2021 user176688. All rights reserved.
//

import UIKit
import Lottie

class BienvenidoCleanse: UIViewController {
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    
     override func viewDidLoad() {
       
         super.viewDidLoad()
        
         roundButton()
      
     }
    
    private func roundButton(){
        
        //signIn button style
        signIn.layer.cornerRadius = 10
        signIn.clipsToBounds = true
        
        //signUp button style
        signUp.layer.cornerRadius = 10
        signUp.clipsToBounds = true
        
        
    }
     
    

}
