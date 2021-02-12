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

    @IBOutlet weak var imagenanimacion: AnimationView!
     override func viewDidLoad() {
        var animationView : AnimationView?
         super.viewDidLoad()
         
       animationView = .init(name: "people")
         animationView?.frame = imagenanimacion.bounds
          animationView?.loopMode = .loop
        animationView? .animationSpeed = 0.5
           imagenanimacion.addSubview(animationView!)
    animationView?.play()
          imagenanimacion.sendSubviewToBack(animationView!)
     }
     
    

}
