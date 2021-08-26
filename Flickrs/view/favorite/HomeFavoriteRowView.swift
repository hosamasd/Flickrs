//
//  HomeFavoriteRowView.swift
//  Flickrs
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct HomeFavoriteRowView: View {
    
    var x = "http://farm9.staticflickr.com/8440/7790251192_50b0af1b38.jpg"
       @ObservedObject var vm:HomeViewModel
       var p:Photo
       
       var body: some View {
           ZStack(alignment:Alignment(horizontal: .trailing, vertical: .top)) {
              
            RemoteImage(url: x )
//               RemoteImage(url: x , loading:  Image(systemName: "flag.fill"), failure: Image(systemName: "flag.fill"))
                   .frame( height: 170)
                   .onTapGesture(perform: {
                       print(123)
                   })
               
               Button(action: {withAnimation{
                   vm.addOrRemoveFavoite(p: p)
               }}, label: {
                
                   Image(systemName:vm.checkFavorites(p: p) ? "bookmark.fill" : "bookmark")
                   .font(.system(size: 50))
                   .foregroundColor(Color.red)
                   
                   
               })
               
           }
       }
}

struct HomeFavoriteRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFavorite(vm: HomeViewModel())
    }
}
