


import Foundation
import Alamofire



class Request{
    
static let shared = Request()
    
    public init() {}
    
    //MARK: Peticiones autentificacion
    func login(parameters:[String:String])  -> DataRequest{
        

        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.login, method: .post, parameters:parameters , encoder: JSONParameterEncoder.default).response{ response in

        }
    }

    func register(parameters:[String:String])-> DataRequest {
           
           AF.request(Endpoints.shared.baseURL+Endpoints.shared.register, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil, interceptor:nil).response { response in
               debugPrint(response)
           }
       }

    //MARK: Peticiones perfil de usuario
    func InfoUser()-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
          "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
            
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.getProfile, method: .get,headers: headers).responseJSON { response in
            
        }
    }
    
    func updateProfile (parameters:[String:String])  -> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
        ]

        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.updateProfile, method: .put, parameters:parameters, encoder: JSONParameterEncoder.default, headers: headers).response{ response in

        }
    }
    
    func getOfferBuyed()-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.buyedOffers, method: .get, headers: headers).response { response in
            debugPrint(response)
        }
    }
    
    //MARK: peticiones de ofertas
    
    func getOffers()-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.getOffers, method: .get, headers: headers).response { response in
            debugPrint(response)
        }
    }

    func BuyOffer(parameters:[String:String])-> DataRequest {
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.buyOffer, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers, interceptor:nil).response { response in
            debugPrint(response)
        }
        
    }

    //MARK: Peticionesde contenedores
    func getContainers()-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.getContainers, method: .get, headers: headers).response { response in
            debugPrint(response)
        }
    }
    
    
    
    func tradePlastic(parameters:[String:String])  -> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "Token")!
        ]

        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.trade, method: .post, parameters:parameters, encoder: JSONParameterEncoder.default, headers: headers).response{ response in

        }
    }

  
 

    
}

