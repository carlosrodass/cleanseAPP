


class User: Decodable,Encodable {
    var user : String
    var pass : String
   
    enum llavesNombres: String ,CodingKey {
        case user = "usuario"
        case pass = "password"
    }
    
    init(user:String , passwor:String) {
        self.user = user
        self.pass = passwor
        
    }
    public func getUserlist()->[String:Any]{
    
        return ["usuario":user,"password":pass]
    
    }
    }
