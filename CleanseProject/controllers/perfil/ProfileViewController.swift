//
//  ProfileViewController.swift
//  CleanseProject
//
//  Created by user177278 on 2/14/21.
//  Copyright © 2021 user176688. All rights reserved.
//
import Foundation
import UIKit

class ProfileViewController: UIViewController {
    var dataUser:Userr?
    
    //Oulets
    @IBOutlet weak var roundProfileImage: UIImageView!
    @IBOutlet weak var logOutOulet: UIButton!
    @IBOutlet weak var saveOulet: UIButton!
    @IBOutlet weak var userNameProfile: UILabel!
    @IBOutlet weak var pointsProfile: UILabel!
    
    
    @IBAction func logOutButton(_ sender: Any) {
    }
    
    @IBAction func saveChangesButton(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundImage()
        roundButtons()
        
        let userToken:String = UserDefaults.standard.string(forKey: "token")!
        print("token guardado \(userToken)")

        let parameters : [String:String] = [

            "token" : userToken
        ]


        let request = Request.shared.InfoUser(parameters: parameters)
        print(userToken)
        request.response(completionHandler: { (response) in

            guard let data = response.data else {return}
            do{
                self.dataUser = try JSONDecoder().decode(Userr.self, from: data)
                print(self.dataUser?.username)
                self.userNameProfile.text = self.dataUser?.username
                self.pointsProfile.text = self.dataUser?.puntos
                debugPrint(response)
            }catch{
                print("estoy aqui")
            }
        })
        
    }
    
    
    private func roundImage(){
        //profile image style
        roundProfileImage.layer.cornerRadius = roundProfileImage.frame.size.width / 2
        roundProfileImage.layer.borderColor = UIColor.white.cgColor
        roundProfileImage.layer.borderWidth = 2
        roundProfileImage.clipsToBounds = true
    }
    
    private func roundButtons(){
        //logout button style
        logOutOulet.layer.cornerRadius = 10
        logOutOulet.clipsToBounds = true
        
        //save changes button style
        saveOulet.layer.cornerRadius = 10
        saveOulet.clipsToBounds = true
    }
}
