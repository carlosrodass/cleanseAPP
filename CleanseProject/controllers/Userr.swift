import UIKit
import Foundation

   
class Userr: Encodable, Decodable {
    
  
    private var _email:String
    private var _username:String
    private var _password:String?
    private var _confirmpasswor:String?
    private var _puntos:Int?
    
    enum CodingKeys:String, CodingKey {
 
        case _username = "username"
        case _email = "email"
        case _password = "password"
        case _confirmpasswor = "password_confirmation"
        case _puntos = "points"
    }
    
    init(username:String, email:String,  password:String , confirmpassword:String, puntos:Int){
        
        self._username = username
        self._email = email
        self._password = password
        self._confirmpasswor = confirmpassword
        self._puntos = puntos
        
    }
 
    ///Registro de usuario
    public func upUserserver()->[String:Any]{
     
        return ["username":_username,"email":_email,"password":_password!,"password_confirmation":_confirmpasswor!, "points":_puntos!]
     
     }
    ///Perfil de usuario (datos)
    public func getUser()->[String:Any]{
        return["username":_username, "points":_puntos!]
    }
    
    
    
    public var username: String{
        get{
            return self._username
        }
    }
    
    public var puntos: Int{
        get{
            return self._puntos ?? 0
        }
    }
     
    
    
  

    
    }
