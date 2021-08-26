//
//  HomeViewModel.swift
//  Flicker Task
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var searchQuery = ""
    var searchCancelbale:AnyCancellable? = nil
    @Published var searchmagesArrayss:[Photo]?     = nil
    @Published var favoriteImagesArray:[Photo]     = [Photo]()
    
    
    @Published var alert = false
    @Published var alertMsg = ""
    @Published var isLoading = false
    @Published var isShowFavorite=false
    @Published var isFullScreen=false
    @Published var selectedImage="http://farm9.staticflickr.com/8440/7790251192_50b0af1b38.jpg"

    init() {
        searchCancelbale = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.8, scheduler: RunLoop.main)//0.6
            .sink(receiveValue: {str in
                
                if str == ""{
                    //                    reset data
                    self.searchmagesArrayss = nil
                    
                }else {
                    //search data
                    
                    self.fetchData()
                }
            })
        
    }
    
    func fetchData()  {
        withAnimation{isLoading.toggle()}
        HomeServices.shared.getSearchText(txt: searchQuery) { mains, err in
            if let err=err{
                DispatchQueue.main.async {
                    withAnimation{self.isLoading.toggle()}

                    self.alertMsg=err.localizedDescription
                    self.alert.toggle()
                    return
                }
                
            }
            
            guard let mai = mains else {return}
            DispatchQueue.main.async {
                withAnimation{self.isLoading.toggle()}

                self.searchmagesArrayss=mai.photos?.photo
            }
        }
        
    }
    
    func checkFoundFavorites() -> Bool {
        favoriteImagesArray.isEmpty
    }
    
    func checkFavorites(p:Photo) -> Bool {
        favoriteImagesArray.contains(where:{$0.id==p.id})
    }
    
    func addOrRemoveFavoite(p:Photo)  {
        checkFavorites(p: p) ? favoriteImagesArray.removeAll(where: {$0.id == p.id}) : favoriteImagesArray.append(p)
    }
    
    func getImage(p:Photo) -> String {
        "http://farm\(p.farm ?? 9).staticflickr.com/\(p.server ?? "8440")/\(p.id ?? "7790251192")_\(p.secret ?? "50b0af1b38").jpg".toSecrueHttps()
        
    }
}
