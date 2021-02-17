


import Foundation
import Alamofire



class Request{
    
static let shared = Request()
    
    public init() {}
    
    func login(parameters:[String:String])  -> DataRequest{

        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.login, method: .post, parameters:parameters , encoder: JSONParameterEncoder.default).response{ response in
            debugPrint(response)
        }
    }
    
    func register(parameters:[String:String])-> DataRequest {
           
           AF.request(Endpoints.shared.baseURL+Endpoints.shared.register, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: nil, interceptor:nil).response { response in
               debugPrint(response)
           }
       }
    
    
    func InfoUser(parameters:[String:String])-> DataRequest{
        
        let headers:HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":UserDefaults.standard.string(forKey: "token")!
        ]
        
        return AF.request(Endpoints.shared.baseURL + Endpoints.shared.getProfile, method: .post,
                          parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
    }
  
 

    
}
