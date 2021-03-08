


import Foundation
import Alamofire



class Request{
    
static let shared = Request()
    
    public init() {}
    
    /**
    * funcion de Login
    * Params : [String]
    */
    func login(parameters:[String:String])  -> DataRequest{
        
///        let headers:HTTPHeader = []
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.login, method: .post, parameters:parameters , encoder: JSONParameterEncoder.default).response{ response in
///        debugPrint(response, "respuesta")
        }
    }
    
    /**
    * funcion de registro
    * Params : [String]
    */
    func register(parameters:[String:String])-> DataRequest {
           
           AF.request(Endpoints.shared.baseURL+Endpoints.shared.register, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil, interceptor:nil).response { response in
               debugPrint(response)
           }
       }
    
    /**
    * funcion de  ver perfil de usuario
    * Params : [String]
    */
    func InfoUser(parameters:[String:String])-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL + Endpoints.shared.getProfile, method: .get,
                          parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
    }
    
    func getOffers(parameters:[String:String])-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.getOffers, method: .get, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers, interceptor:nil).response { response in
            debugPrint(response)
        }
    }
    
    
    /**
    * funcion de tradeo ofertas
    * Params : [String]
    */
    func BuyOffer(parameters:[String:String])-> DataRequest {
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":"Bearer " + UserDefaults.standard.string(forKey: "token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.buyOffer, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers, interceptor:nil).response { response in
            debugPrint(response)
        }
        
    }
  
 

    
}
