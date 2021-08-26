//
//  HomeServices.swift
//  Flicker Task
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

class HomeServices {
   static let shared = HomeServices()
    
    
    func getSearchText(txt:String,completion: @escaping (MainSearchModel?, Error?) -> Void)  {
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(MainServices.api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=100&text=\(txt)&page=1"
        MainServices.authSersvicesGetMethodGenerics(urlString: urlString, completion: completion)

    }
    
    func request(_ searchText: String, pageNo: Int, completion: @escaping (Result<Photos?>) -> Void) {
        
        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(MainServices.api_key)&format=json&nojsoncallback=1&safe_search=1&per_page=100&text=\(searchText)&page=1"

        
        MainServices.shared.request(searchText) { (result) in
            switch result {
            case .Success(let responseData):
                if let model = self.processResponse(responseData) {
                    if let stat = model.stat, stat.uppercased().contains("OK") {
                        return completion(.Success(model.photos))
                    } else {
                        return completion(.Failure(MainServices.errorMessage))
                    }
                } else {
                    return completion(.Failure(MainServices.errorMessage))
                }
            case .Failure(let message):
                return completion(.Failure(message))
            case .Error(let error):
                return completion(.Failure(error))
            }
        }
    }
    
    func processResponse(_ data: Data) -> MainSearchModel? {
        do {
            let responseModel = try JSONDecoder().decode(MainSearchModel.self, from: data)
            return responseModel
            
        } catch {
            print("Data parsing error: \(error.localizedDescription)")
            return nil
        }
    }
}
