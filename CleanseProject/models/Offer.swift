import UIKit
import Foundation

class Offer{
    
    public var _image:UIImage
    private var _offer:String
    private var _market: String
    private var _points: Int
    private var _stock: Int
    
    
    enum CodingKeys:String, CodingKey {
        case _offer = "offer"
        case _market = "market"
        case _points = "points"
        case _stock = "stock"
    }
    

    init( image:UIImage,offer:String, market:String, points:Int, stock:Int){
        
        self._image = image
        self._offer = offer
        self._market = market
        self._points = points
        self._stock = stock
    }
    
//    required init(from decoder: Decoder) throws {
//        <#code#>
//    }
  
    
    ///comprar ofertas
    public func buyOffer()->[String:Any]{
        return["offer":_offer, "market":_market, "points":_points]
    }
    ///Ver todas los datos de las ofertas
    public func getOffers()->[String:Any]{
        return["offer":_offer, "market":_market, "points":_points, "stock":_stock]
    }
    
     var gsOfferName:String{
        get{
            return self._offer
        }
        set(newOfferName){
            self._offer = newOfferName
        }
    }

     var gsMarket:String{
        get{
            return self._market
        }
        set(newMarketName){
            self._market = newMarketName
        }
    }
    
     var gsPoints:Int{
        get{
            return self._points
        }
        set(newPoints){
            self._points = newPoints
        }
    }
    
     var gsStock:Int{
        get{
            return self._stock
        }
        set(newStock){
            self._stock = newStock
        }
    }
    
//    public func getPoints()->[String:Any]{
//        return["points":_points]
//    }
//
//    public func getStock()->[String:Any]{
//        return["stock":_stock]
//    }



    
    
}
