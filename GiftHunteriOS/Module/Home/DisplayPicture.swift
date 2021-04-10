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
            getImageFromURL(url: firebaseDataservice.profile?.userDisplayPicture ?? "")
        }
    }

    func getImageFromURL(url: String) -> AnyView {
        return  AnyView(
            AsyncImage(
                url: URL(string: url),
                placeholder: image
                    .resizable()
                    .foregroundColor(Color.black)
            )
            .padding()
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
 
