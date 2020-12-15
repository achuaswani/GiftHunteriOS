//
//  DisplayPicture.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/9/20.
//

import SwiftUI

struct DisplayPicture: View {
    @State var image: Image = Image("noImage")
    @State var imageURL: URL?
    @State var isShowPicker: Bool = false
    @EnvironmentObject var firebaseDataservice: FirebaseDataService
    
    var body: some View {
        HStack {
            getImageFromURL(url: URL(string: firebaseDataservice.profile?.userDisplayPicture ?? ""))
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
                ImagePicker(image: $image, imageURL: $imageURL)
                    .onDisappear {
                        if let url = imageURL, firebaseDataservice.profile?.userDisplayPicture != url.absoluteString {
                            firebaseDataservice.updateDisplayPicture(filePath: url)
                        }
                    }
            }
            .onTapGesture {
                isShowPicker = true
            }
        )
    }
}
 
