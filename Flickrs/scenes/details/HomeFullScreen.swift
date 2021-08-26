//
//  HomeFullScreen.swift
//  Flickrs
//
//  Created by hosam on 26/08/2021.
//

import SwiftUI

struct HomeFullScreen: View {
    @ObservedObject var vm:HomeViewModel
    
    var x = "https://farm66.staticflickr.com/65535/51401709041_a82be70e4a.jpg"
    @StateObject var vms = ImageLoader()

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
            
            ZStack {
                
                if vms.image != nil {
                    Image(uiImage: vms.image!)
                        .resizable()
                        .frame(maxWidth:.infinity,maxHeight: .infinity)

                }else {
                    Image(systemName: "person")
                        .resizable()
                        .frame(maxWidth:.infinity,maxHeight: .infinity)

                }
                
            }
            
//            RemoteImage(url: x )//, loading:  Image(systemName: "flag.fill"), failure: Image(systemName: "flag.fill"))
            
            HStack {
                Button(action: {withAnimation{vm.isFullScreen.toggle()}}, label: {
                    Image(systemName: "arrow.backward")
                        .font(.system(size: 30))
                        .foregroundColor(.red)
                    //                    .offset(x:200,y:60)
                })
                
                Spacer()
            }
            .padding(.top,60)
            .padding(.leading,20)
            
        })
        //        .frame(maxWidth:.infinity,maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            guard let url = URL(string: x) else {return}
            vms.loadImage(with: url)
        })
    }
}

struct HomeFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFullScreen(vm: HomeViewModel())
    }
}
