//
//  ImagePicker.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/8/20.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode
    @Binding var image: Image
    @Binding var imageURL: URL?
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        @Binding var presentationMode: PresentationMode
        @Binding var image: Image
        @Binding var imageURL: URL?
        init(
            presentationMode: Binding<PresentationMode>,
            image: Binding<Image>,
            imageURL: Binding<URL?>) {
            _presentationMode = presentationMode
            _image = image
            _imageURL = imageURL
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo
                                    info: [UIImagePickerController.InfoKey: Any]) {
            imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                self.image = Image(uiImage: uiImage)
            }
            
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image, imageURL: $imageURL)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {
        // TODO: update UIView
    }
}
