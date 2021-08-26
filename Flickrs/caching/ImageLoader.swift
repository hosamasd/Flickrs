//
//  ImageLoader.swift
//  SwiftUIMovieDb
//
//  Created by Alfian Losari on 23/05/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import UIKit

func getImageUrl(str:String) -> URL {
    guard let url = URL(string: str) else { return URL(string: "http://52.59.228.9:9102/media/billiards-ball.jpg")! }
    return url
    
}

private let _imageCache = NSCache<AnyObject, AnyObject>()

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    @Published var isLoading = false
    
    var imageCache = _imageCache

    func loadImage(with url: URL) {
        let urlString = url.absoluteString
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
       
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            do {
                let data = try Data(contentsOf: url)
                guard let image = UIImage(data: data) else {
                    return
                }
                self.imageCache.setObject(image, forKey: urlString as AnyObject)
                DispatchQueue.main.async { [weak self] in
                    self?.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//    func loadImageFromString(with urlString: String) {
////            let urlString = url.absoluteString
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//        
//        DispatchQueue.global(qos: .background).async { [weak self] in
//            guard let self = self else { return }
//            do {
//                let data = try Data(contentsOf: url)
//                guard let image = UIImage(data: data) else {
//                    return
//                }
//                self.imageCache.setObject(image, forKey: urlString as AnyObject)
//                DispatchQueue.main.async { [weak self] in
//                    self?.image = image
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
}