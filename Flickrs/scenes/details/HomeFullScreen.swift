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
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top), content: {
            
            RemoteImage(url: x )//, loading:  Image(systemName: "flag.fill"), failure: Image(systemName: "flag.fill"))
                .frame(maxWidth:.infinity,maxHeight: .infinity)
            
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
    }
}

struct HomeFullScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFullScreen(vm: HomeViewModel())
    }
}
