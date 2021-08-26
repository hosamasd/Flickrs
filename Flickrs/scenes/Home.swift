//
//  Home.swift
//  Flicker Task
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var vm =  HomeViewModel()
    @State var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 3)
    
    var body: some View {
        VStack{
            
            HomeTopView(vm: vm, columns: $columns)
            
            Spacer()
            if vm.searchQuery == "" && vm.searchmagesArrayss == nil {
                
                VStack {
                    
                    Spacer()
                    
                    Text("Please enter image charcters \n for Searching...")
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                }
            }
            if let chc = vm.searchmagesArrayss {
                
                if chc.isEmpty {
                    Text("No Results Found")
                        .padding(.top,20)
                }
                else {
                    ScrollView(showsIndicators:false){
                        
                        LazyVGrid(columns: columns,spacing: 20){
                            
                            //
                            ForEach(chc,id:\.id){c in
                                
                                
                                HomeRowView(x:vm.getImage(p: c),vm: vm,p: c )
                                
                                
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding(.top,20)
                }
            }
            else {
                if vm.searchQuery != "" {
                    VStack {
                        
                        ProgressView()
                            .foregroundColor(.black)
                            .padding(.top,20)
                        
                        Spacer()
                    }
                }
            }
            
        }
        .alert(isPresented: $vm.alert) {
            
            Alert(title: Text("Error"), message: Text(self.vm.alertMsg), dismissButton: .default(Text("Ok")))
        }
        
        .background(EmptyView()
                        .fullScreenCover(isPresented: $vm.isFullScreen, content: {
                            HomeFullScreen(vm: vm,x: vm.selectedImage)
                                
                                .navigationBarTitle("")
                                .navigationBarHidden(true)
                                .navigationBarBackButtonHidden(true)
                        }))
        .fullScreenCover(isPresented: $vm.isShowFavorite, content: {
            HomeFavorite(vm: vm)
                
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        })
    }
    
    //    func getImage(p:Photo) -> String {
    //        "http://farm\(p.farm ?? 9).staticflickr.com/\(p.server ?? "8440")/\(p.id ?? "7790251192")_\(p.secret ?? "50b0af1b38").jpg".toSecrueHttps()
    //    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
