//
//  HomeFavorite.swift
//  Flickrs
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct HomeFavorite: View {
    @ObservedObject var vm : HomeViewModel
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    
    
    var body: some View {
        VStack {
            
            HomeFavoriteTopView(vm: vm, columns: $columns)
            
            if vm.favoriteImagesArray.isEmpty {
                
                
                Text("No Images Found")
                    .padding(.top,20)
            }
            else {
                ScrollView(showsIndicators:false){
                    
                    LazyVGrid(columns: columns,spacing: 20){
                        
                        //
                        ForEach(vm.favoriteImagesArray,id:\.id){c in
                            
                            
                            HomeFavoriteRowView(x:vm.getImage(p: c),vm: vm,p: c )
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .padding(.top,20)
            }
            
            
            Spacer()
        }
    }
}

struct HomeFavorite_Previews: PreviewProvider {
    static var previews: some View {
        HomeFavorite(vm: HomeViewModel())
    }
}
