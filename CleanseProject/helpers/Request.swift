

import Foundation
import Alamofire

class Request{
    
    func PostUsers(user :String, pass: String ){
        

        
        let url = URL(string:
        "https://superapi.netlify.app/api/register")

        let json = ["user" : user , "pass" : pass]

       AF.request(url!, method: .post, parameters: json,
        encoding: JSONEncoding.default, headers: nil).responseJSON {
        response in

            print(json)

            print(response)
            
        
        }
        
        
    }
    func GetUsers()->DataRequest{
        let url = "https://superapi.netlify.app/api/users"
        

        return  AF.request( url ,method: .get,parameters: nil,encoding: URLEncoding.default,headers: nil,interceptor: nil)
            //response in
            //      if let json = response.result {
            //   var users: [User] = []
            //      print(json)
            
            //  for user in json as! [[String : Any]] {

            //  users.append(User(json: user))

           
        //  }
            
        //  }
        }
        
    }
    


