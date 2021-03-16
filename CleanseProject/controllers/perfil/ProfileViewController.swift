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
import BLTNBoard

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataUser:Userr?
    var buyed:Buyed?

    var byOffers : [Buyed] = []
    
    //Oulets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var roundProfileImage: UIImageView!
    @IBOutlet weak var logOutOulet: UIButton!
    @IBOutlet weak var userNameProfile: UILabel!
    @IBOutlet weak var pointsProfile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundImage()
        roundButtons()
        tableView.delegate = self
        tableView.dataSource = self
                
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
           ///Request con informacion del usuario (ptos y nombre del usuario)
           let requestI = Request.shared.InfoUser()

           requestI.response(completionHandler: { (response) in
               debugPrint(response)

               guard let data = response.data else{return}

               do{
                   self.dataUser = try JSONDecoder().decode(Userr.self, from: data)
                   self.userNameProfile.text = self.dataUser?.username
                   self.pointsProfile.text = String(self.dataUser!.puntos)

               }catch{
                   print("error == \(error)")
               }
           })
        
        
        ///Request con lista de compras realizadas por el usuario(Nombre del supermercado y puntos gastados)
        let requestB = Request.shared.getOfferBuyed()

        requestB.responseJSON { (response) in
            if let body = response.value as? [[String:Any]]{
                for i in 0..<body.count{
                    self.byOffers.append(Buyed(market: body[i]["Market"] as! Int, points: body[i]["Points"] as! Int))
                }
                print(self.byOffers)
                self.tableView.reloadData()
            }
        }
           
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return byOffers.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "mycell") as! offersBuyedCell
        
        cell.cellMarketLabel.text = String(byOffers[indexPath.row]._market)
        cell.cellPointsLabel.text = String(byOffers[indexPath.row]._points)
        
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

    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        
    }
    
}
