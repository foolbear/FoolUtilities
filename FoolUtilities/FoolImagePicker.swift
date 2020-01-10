//
//  FoolImagePicker.swift
//  FoolUtilities
//
//  Created by foolbear on 2020/1/5.
//  Copyright © 2020 Foolbear Co.,Ltd. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct FoolImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    var sourceType: UIImagePickerController.SourceType
    @Binding var image: UIImage?
    
    public init(sourceType: UIImagePickerController.SourceType, image: Binding<UIImage?>) {
        self.sourceType = sourceType
        self._image = image
    }
    
    public func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
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
        var parent: FoolImagePicker
        
        public init(parent: FoolImagePicker) {
            self.parent = parent
        }
        
        public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let unwrapImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else { return }
            parent.image = unwrapImage
            parent.presentationMode.wrappedValue.dismiss()
            picker.dismiss(animated: true, completion: nil)
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
            picker.dismiss(animated: true, completion: nil)
        }
    }
}
