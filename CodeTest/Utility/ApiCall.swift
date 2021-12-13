//
//  ApiCall.swift
//  ApiCallWithDecodable
//
//  Created by Nirzar on 12/06/18.
//  Copyright © 2018 Nirzar. All rights reserved.
//

import UIKit
import Foundation

class ApiCall: NSObject {
    
    let constValueField = "application/json"
    let constHeaderField = "Content-Type"
    func mainThread(_ completion: @escaping () -> ()) {
        DispatchQueue.main.async {
             completion()
        }
    }

    func post<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true , isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl: apiUrl, params: requestPARAMS as [String : AnyObject], method: "POST", model: model , isLoader : isLoader , isErrorToast : isErrorToast , completion: completion)
    }
    
    func put<T : Decodable ,A>(apiUrl : String, requestPARAMS: [String: A], model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestMethod(apiUrl:apiUrl, params: requestPARAMS as [String : AnyObject], method: "PUT",model: model , isLoader : isLoader , isErrorToast : isErrorToast ,  completion: completion)
    }
    
    func get<T : Decodable>(apiUrl : String, model: T.Type , isLoader : Bool = true , isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestGetMethod(apiUrl: apiUrl, method: "GET", model: model , isLoader : isLoader , isErrorToast : isErrorToast , completion: completion)
    }
    
    func Delete(apiUrl : String,tag : Int, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        requestDeleteMethod(apiUrl: apiUrl, method: "DELETE", tag : tag , completion: completion)
    }
    
    func requestMethod<T : Decodable>(apiUrl : String, params: [String: AnyObject], method: NSString, model: T.Type ,isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        request.httpMethod = method as String
        request.setValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let jsonTodo: NSData
        do {
            jsonTodo = try JSONSerialization.data(withJSONObject: params, options: []) as NSData
            request.httpBody = jsonTodo as Data
        } catch {
            print("Error: cannot create JSON from todo")
            return
        }
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
        
            
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let decoder = JSONDecoder()
            do {
                
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                
                let dictResponse = try decoder.decode(GeneralResponseModel.self, from: data)
                
                let code = dictResponse.code!
                
                if code == "200" {
                    let dictResponsee = try decoder.decode(model, from: data )
                    self.mainThread {
                        completion(true,dictResponsee as AnyObject)
                    }
                } else {
                    self.mainThread {
                        completion(false,dictResponse as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestGetMethod<T : Decodable>(apiUrl : String, method: String, model: T.Type, isLoader : Bool = true, isErrorToast : Bool = true , completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        
        request.httpMethod = method
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
          
            guard let data = data, error == nil else {
                completion(false, nil)
                return
            }
            let decoder = JSONDecoder()
            do {
                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(convertedJsonIntoDict)
                }
                let dictResponse = try decoder.decode(GeneralResponseModel.self, from: data )
                
                let code = dictResponse.code!
                
                if code == "200" {
                    let dictResponsee = try decoder.decode(model, from: data )
                    self.mainThread {
                        completion(true,dictResponsee as AnyObject)
                    }
                } else {
                    self.mainThread {
                        completion(false,dictResponse as AnyObject)
                    }
                }
                
            } catch let error as NSError {
                print("\n\n===========Error===========")
                print("Error Code: \(error._code)")
                print("Error Messsage: \(error.localizedDescription)")
                if let str = String(data: data, encoding: String.Encoding.utf8){
                    print("Print Server data:- " + str)
                }
                debugPrint(error)
                print("===========================\n\n")
                
                debugPrint(error)
                completion(false, error as AnyObject)
            }
        })
        task.resume()
    }
    
    func requestDeleteMethod(apiUrl : String, method: String,tag: Int, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        
        var request = URLRequest(url: URL(string: apiUrl)!)
        
        // Set request HTTP method to GET. It could be POST as well
        request.httpMethod = method
        request.addValue(constValueField, forHTTPHeaderField: constHeaderField)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task: URLSessionDataTask = session.dataTask(with : request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            
            if error != nil{
                return
            }
            
            _ = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            // print("responseString = \(responseString)")
            
            do {
                if tag == 0 {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                        completion(true, convertedJsonIntoDict)
                    } else {
                        completion(false, nil)
                    }
                    
                } else {
                    if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                        completion(true, convertedJsonIntoDict)
                    } else {
                        completion(false, nil)
                    }
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }
}

//MARK: - Model Class
class GeneralResponseModel : Codable {
    
    let code : String?
    
}

