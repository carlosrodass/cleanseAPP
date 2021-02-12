


import Foundation
import Alamofire



class Request{
    
static let shared = Request()
    
    private init() {}
    
    func login(parameters:[String:String])  -> DataRequest{

        return AF.request(Endpoints.shared.baseURL+Endpoints.shared.login, method: .post, parameters:parameters , encoder: JSONParameterEncoder.default).response{ response in
            debugPrint(response)
        }
    }
  
 

    
}
