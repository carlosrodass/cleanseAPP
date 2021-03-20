import Foundation


class Container: Encodable, Decodable {
    
    private var _street_name:String ///poi.title
    private var _street_number: Int ///poi.subtitle
    private var _lat: Double ///poi.lat
    private var _long: Double ///poi.long
    
    enum CodingKeys:String, CodingKey {

        case _street_name = "street_name"
        case _street_number = "street_number"
        case _lat = "lat"
        case _long = "long"
    }
    
    
    init(street_name:String, street_number:Int, lat:Double, long:Double){
        self._street_name = street_name
        self._street_number = street_number
        self._lat = lat
        self._long = long
    }
    
    
    var gsStreetName:String{
        get{
            return self._street_name
        }
        set(newStreetName){
            self._street_name = newStreetName
        }
    }
    
    var gsStreetNumber:Int{
        get{
            return self._street_number
        }
        set(newStreetNumber){
            self._street_number = newStreetNumber
        }
    }
    
    var gsLat:Double{
        get{
            return self._lat
        }
        set(newLat){
            self._lat = newLat
        }
    }
    
    var gsLong:Double{
        get{
            return self._long
        }
        set(newLong){
            self._long = newLong
        }
    }
  
}
