//
//  MainServices.swift
//  Flicker Task
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

class MainServices {
    static let shared = MainServices()
    static let api_key = "a4f28588b57387edc18282228da39744"
    static let per_page = 60
    static let mainSearch = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=40&text=mess&page=1"
    static
     let getImage = "http://farm9.staticflickr.com/8440/7790251192_50b0af1b38.jpg"
    
    static   func authSersvicesGetMethodGenerics<T:Codable>(urlString:String,completion:@escaping (T?,Error?)->Void)  {
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            if let err = err {
                completion(nil, err)
                return
            }
            guard let data = data else {return}
            do {
                
                let objects = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(objects, err)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
    
    static func servicesPostMethodGeneric<T:Codable>(postString:String,url:URL,completion:@escaping (T?,Error?)->Void)  {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let error = err {
                completion(nil,error)
            }
            guard let data = data else {return}
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(objects,nil)
            } catch let error {
                completion(nil,error)
            }
        }.resume()
    }
}
