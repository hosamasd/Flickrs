//
//  HomeFavoriteTopView.swift
//  Flickrs
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct HomeFavoriteTopView: View {
    @ObservedObject var vm:HomeViewModel
    @State var show = false
    @State var isTwo = false
    @Binding var columns:[GridItem]
    var body: some View {
        
        HStack {
            Button(action: {withAnimation{vm.isShowFavorite.toggle()}}, label: {
                Image(systemName: "arrow.backward")
                    .foregroundColor(.black)
            })
            Spacer()
            
            Text("Favorites")
                .font(.system(size: 30))
                .fontWeight(.bold)
            
            Spacer()
            
            
            
            Button(action: {
                
                withAnimation(.easeOut){
                    //                            self.vm.fetchData()
                    if columns.count == 1{
                        
                        self.columns.append(GridItem(.flexible(), spacing: 20))
                        isTwo = true
                    }
                    else if columns.count == 2 {
                        if isTwo {
                            columns.append(GridItem(.flexible(), spacing: 20))
                        }else {
                            columns.removeLast()
                        }
                        isTwo = false
                    }
                    else{
                        
                        columns.removeLast()
                    }
                }
                
            }) {
                
                Image(systemName: columns.count == 1 ? "square.grid.2x2.fill" : "rectangle.grid.1x2.fill")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        
        
        
        .padding(.top)
        .padding(.bottom,10)
        .padding(.horizontal)
    }
}


struct HomeFavoriteTopView_Previews: PreviewProvider {
    static var previews: some View {
        HomeFavorite(vm: HomeViewModel())
    }
}
