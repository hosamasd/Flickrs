//
//  HomeRowView.swift
//  Flicker Task
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct HomeRowView: View {
//    var p = Photo(id: "", owner: "", secret: "", server: "", farm: 0, title: "", ispublic: 0, isfriend: 0, isfamily: 0)
    
 var x = "http://farm9.staticflickr.com/8440/7790251192_50b0af1b38.jpg"
    @ObservedObject var vm:HomeViewModel
    var p:Photo
    
    var body: some View {
        ZStack(alignment:Alignment(horizontal: .trailing, vertical: .top)) {
           
            RemoteImage(url: x )
//            RemoteImage(url: x , loading:  Image(systemName: "flag.fill"), failure: Image(systemName: "flag.fill"))
                .frame( height: 170)
                .onTapGesture(perform: {
                    withAnimation{
                        vm.selectedImage=x
                        vm.isFullScreen.toggle()}
                })
            
            Button(action: {withAnimation{
                vm.addOrRemoveFavoite(p: p)
            }}, label: {
             
                Image(systemName:vm.checkFavorites(p: p) ? "bookmark.fill" : "bookmark")
                .font(.system(size: 50))
                .foregroundColor(Color.red)
                
                
            })
            
        }
//            .onAppear(perform: {
//                x = "http://farm\(p.farm ?? 9).staticflickr.com/\(p.server ?? "8440")/\(p.id ?? "7790251192")_\(p.secret ?? "50b0af1b38").jpg"
//                print(x)
//            })
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
