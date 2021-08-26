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
    @StateObject var vms = ImageLoader()

       var body: some View {
           ZStack(alignment:Alignment(horizontal: .trailing, vertical: .top)) {
              
            ZStack {
                
                if vms.image != nil {
                    Image(uiImage: vms.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame( height: 170)
                        .onTapGesture(perform: {
                            withAnimation{
                                vm.selectedImage=x
                                vm.isFullScreen.toggle()}
                        })
                }else {
                    Image(systemName: "person")
                        .resizable()
                        .frame( height: 170)
                        .onTapGesture(perform: {
                            withAnimation{
                                vm.selectedImage=x
                                vm.isFullScreen.toggle()}
                        })
                }
                
            }
               
               Button(action: {withAnimation{
                   vm.addOrRemoveFavoite(p: p)
               }}, label: {
                
                   Image(systemName:vm.checkFavorites(p: p) ? "bookmark.fill" : "bookmark")
                   .font(.system(size: 50))
                   .foregroundColor(Color.red)
                   
                   
               })
               
           }
           .onAppear(perform: {
               guard let url = URL(string: x) else {return}
               vms.loadImage(with: url)
           })
       }
}

struct HomeFavoriteRowView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFavorite(vm: HomeViewModel())
    }
}
