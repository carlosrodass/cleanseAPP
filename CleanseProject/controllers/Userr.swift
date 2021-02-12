import UIKit
import Foundation

   
class Userr: Encodable, Decodable {
    
  
     private var _email:String
     private var _username:String
     private var _password:String?
    private var _confirmpasswor:String?
    private var _puntos:String?
    
    enum CodingKeys:String, CodingKey {
 
        case _username = "username"
        case _email = "email"
        case _password = "password"
        case _confirmpasswor = "password_confirmation"
        case _puntos = "points"
    }
    
    init(username:String, email:String,  password:String , confirmpassword:String, puntos:String){
        
        self._username = username
        self._email = email
        self._password = password
        self._confirmpasswor = confirmpassword
        self._puntos = puntos
        
    }
 
      
   public func upUserserver()->[String:Any]{
     
    return ["username":_username,"email":_email,"password":_password,"password_confirmation":_confirmpasswor, "points":_puntos]
     
     }
     
    
    
  

    
    }
