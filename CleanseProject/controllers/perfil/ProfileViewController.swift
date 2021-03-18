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
    @IBOutlet weak var editOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roundImage()
        roundButtons()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.allowsSelection = true
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
                    self.userNameProfile.text = "@ \(self.dataUser!.username)"
                    self.pointsProfile.text = "\(String(self.dataUser!.puntos)) points"
                
                    UserDefaults.standard.set(self.dataUser!.username, forKey: "username")

               }catch{
                   print("error == \(error)")
               }
           })
        
        
        ///Request con lista de compras realizadas por el usuario(Nombre del supermercado y puntos gastados)
        let requestB = Request.shared.getOfferBuyed()

        requestB.responseJSON { (response) in
            
                if let data = response.value as? [[String:Any]]{
                    
                    for i in 0..<data.count{
                        self.byOffers.append(Buyed(market: data[i]["Market"] as! String, points: data[i]["Points"] as! Int))
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
        
        cell.cellMarketLabel.text = "Offer: \(String(byOffers[indexPath.row]._market))"
        cell.cellPointsLabel.text = "Buyed for : \(String(byOffers[indexPath.row]._points)) points"
        cell.setupCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        print("selected cell \(indexPath.row)")
    }
    
    ///Segue pasando datos entre controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "qrcode" {
                let vc = segue.destination as! QrCodeViewController
                let cell = sender as! offersBuyedCell
                let indexPath = tableView.indexPath(for: cell)

                vc.buyed = byOffers[indexPath!.row]
                present(vc, animated: true)
            }
        }
    
    
    ///Image style
    private func roundImage(){
        roundProfileImage.layer.cornerRadius = roundProfileImage.frame.size.width / 2
        roundProfileImage.layer.borderColor = UIColor.white.cgColor
        roundProfileImage.layer.borderWidth = 2
        roundProfileImage.clipsToBounds = true
    }
    
    ///Buttons styles
    private func roundButtons(){
        editOutlet.layer.cornerRadius = 10
        editOutlet.clipsToBounds = true
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        
        
    }
    
}
