//
//  HomeTopView.swift
//  Flicker Task
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct HomeTopView: View {
    
    @ObservedObject var vm:HomeViewModel
    @State var show = false
    @State var isTwo = false
    @Binding var columns:[GridItem]
    var body: some View {
        HStack(spacing: 15){
            
            if show{
                
                TextField("Search Images", text: $vm.searchQuery)
                // search Bar Functionality...
                Button(action: {
                    
                    withAnimation(.easeOut){
                        
                        // clearing search...
//                        vm.searchQuery = ""
                        // safe side...
                        show.toggle()
                    }
                    
                }) {
                    
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
                
                
            }
            else{
                
                Text("Flicker")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.easeOut){
                        
                        show.toggle()
                    }
                    
                }) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
                
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
                
                if !vm.checkFoundFavorites() {
                    
                    
                    Button(action: {withAnimation{
                        vm.isShowFavorite.toggle()
                    }}, label: {
                        
                        Image(systemName: "bookmark.fill" )
                            .font(.system(size: 20))
                            .foregroundColor(Color.red)
                        
                        
                    })
                }
            }
            
            
        }
        .padding(.top)
        .padding(.bottom,10)
        .padding(.horizontal)
    }
}

struct HomeTopView_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
