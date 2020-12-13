//
//  DisplayPicture.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/9/20.
//

import SwiftUI

struct DisplayPicture: View {
    @State var user: User
    @State var image: Image = Image("noImage")
    @State var isShowPicker: Bool = false
    var body: some View {
        HStack {
            getImageFromURL(url: user.photoURL)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 7)
        }
    }

    func getImageFromURL(url: URL?) -> AnyView {
        return  AnyView(AsyncImage(
                       url: url,
                       placeholder: image.resizable().aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.black)
                   )
            .padding()
            .aspectRatio(contentMode: .fit)
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(image: self.$image, user: $user)
            }
            .onTapGesture {
                isShowPicker = true
            }
        )
    }
}

struct DisplayPicture_Previews: PreviewProvider {
    static var previews: some View {
        DisplayPicture(user: User.default)
    }
}
