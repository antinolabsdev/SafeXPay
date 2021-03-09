//
//  DataService.swift
//  SafexPay
//
//  Created by Sandeep on 11/09/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import Foundation
import Alamofire

class DataService {

    private init() {}
    static var instance = DataService()
    
    //User Defaults Reference
    let defaults = UserDefaults.standard

    func getRequest(url:String, header:[String:String]?,completion: @escaping (_ status:Bool, _ data:Any?)->()) {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseString { response in
            if response.response?.statusCode == 200 {
                completion(true,response.result.value)
            }else{
                completion(false,nil)
            }
        }
    }
    
    func getRequestDictnry(url:String, header:[String:String]?,completion: @escaping (_ sataus:Bool,_ data:NSDictionary?)->()) {
         Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            if let responseJson = response.result.value as? NSDictionary {
                if let errorDetails = responseJson.value(forKey: "error_details") as? NSDictionary {
                    if errorDetails.value(forKey: "error_code") as? String == "1" {
                        completion(true,responseJson)
                    }else {
                        completion(false,nil)
                    }
                }
            } else {
                completion(false,nil)
            }
        }
     }

    func postRequest(url:String, postParam: [String : Any], header:[String:String]?,completion: @escaping (_ sataus:Bool,_ data:NSDictionary?)->()) {
        Alamofire.request(url, method: .post, parameters: postParam, encoding: JSONEncoding.default, headers: header).responseJSON { response in
            if let responseJson = response.result.value as? NSDictionary {
                if let errorDetails = responseJson.value(forKey: "error_details") as? NSDictionary {
                    if errorDetails.value(forKey: "error_code") as? String == "1" {
                        completion(true,responseJson)
                    }else {
                        completion(false,nil)
                    }
                }
            } else {
                completion(false,nil)
            }
        }
    }
    
}
