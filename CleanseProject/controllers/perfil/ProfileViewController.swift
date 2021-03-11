//
//  ProfileViewController.swift
//  CleanseProject
//
//  Created by user177278 on 2/14/21.
//  Copyright © 2021 user176688. All rights reserved.
//
import Foundation
import UIKit
import Alamofire

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataUser:Userr?
    var buyed:Buyed?
    
    var arrayOffersBuyed : [Buyed] = []
    
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
        
        ///Request con informacion del usuario (ptos y nombre del usuario)
//        let requestI = Request.shared.InfoUser()
//
//        requestI.response(completionHandler: { (response) in
//            debugPrint(response)
//
//            guard let data = response.data else{return}
//
//            do{
//                self.dataUser = try JSONDecoder().decode(Userr.self, from: data)
//                self.userNameProfile.text = self.dataUser?.username
//                self.pointsProfile.text = String(self.dataUser!.puntos)
//
//            }catch{
//                print("error == \(error)")
//            }
//        })
        
        ///Request con lista de compras realizadas por el usuario(Nombre del supermercado y puntos gastados)
//        let requestB = Request.shared.getOfferBuyed()
//
//        requestB.response(completionHandler: { (response) in
//            debugPrint(response)
//
//            guard let data = response.data else{return}
//
//            do{
//                //Rellenar array de ofertas compradas
//                print(data)
//
//            }catch{
//                print("error == \(error)")
//            }
//        })
        
        arrayOffersBuyed = [Buyed.init(image: "ff", market: "Mercadona", points: 10),
                            Buyed.init(image: "aa", market: "carrefour", points: 10),
                            Buyed.init(image: "ff", market: "lidl", points: 10)
        ]
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arrayOffersBuyed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offersBuyedCell(style: offersBuyedCell.CellStyle.subtitle, reuseIdentifier: "mycell")
        
        cell.setData(with: arrayOffersBuyed[indexPath.row])
        

        return cell
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
