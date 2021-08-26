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
}
