import UIKit
import Foundation

class Offer: Encodable, Decodable{
    
//    private var _image:String
    private var _offer:String
    private var _market: String
    private var _points: Int
    private var _stock: Int
    private var _offerId: Int
    
    
    enum CodingKeys:String, CodingKey {
//        case _image = "image"
        case _offer = "offer"
        case _market = "market"
        case _points = "points"
        case _stock = "stock"
        case _offerId = "offerId"
    }
    

    init(offer:String, market:String, points:Int, stock:Int, offerId:Int){
//        self._image = image
        self._offer = offer
        self._market = market
        self._points = points
        self._stock = stock
        self._offerId = offerId
    }

    ///comprar ofertas
    public func buyOffer()->[String:Any]{
        return["offer":_offer, "market":_market, "points":_points]
    }
    ///Ver todas los datos de las ofertas
    public func getOffers()->[String:Any]{
        return["offer":_offer, "market":_market, "points":_points, "stock":_stock]
    }
    
//    var gsImage:String{
//        get{
//            return self._image
//        }
//        set(newImage){
//            self._image = newImage
//        }
//    }
    
    var gsOfferId:Int{
        get{
            return self._offerId
        }
        set(newOfferId){
            self._offerId = newOfferId
        }
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

