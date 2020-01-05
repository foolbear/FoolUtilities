//
//  FoolImagePicker.swift
//  StudyCards
//
//  Created by foolbear on 2020/1/5.
//  Copyright © 2020 Foolbear Co.,Ltd. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    @Binding var showing: Bool
    @Binding var image: Image?
    
    public init(sourceType: UIImagePickerController.SourceType, showing: Binding<Bool>, image: Binding<Image?>) {
        self.sourceType = sourceType
        self._showing = showing
        self._image = image
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(sourceType: sourceType, showing: $showing, image: $image)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<FoolImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return picker }
        picker.sourceType = sourceType
        picker.allowsEditing = true
        return picker
    }
    
    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<FoolImagePicker>) {
    }

    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var sourceType: UIImagePickerController.SourceType
        @Binding var showing: Bool
        @Binding var image: Image?
        
        public init(sourceType: UIImagePickerController.SourceType, showing: Binding<Bool>, image: Binding<Image?>) {
            self.sourceType = sourceType
            self._showing = showing
            self._image = image
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            image = Image(uiImage: unwrapImage)
            showing = false
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            showing = false
        }
    }
}
