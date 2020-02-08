//
//  ImageConverter.swift
//  cicili_cliente
//
//  Created by ARIANA SANCHEZ on 10/01/20.
//  Copyright © 2020 CICILI. All rights reserved.
//

import UIKit


class ImageConverter {

    func base64ToImage(_ base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else { return nil }
        return UIImage(data: imageData)
    }

    func imageToBase64(_ image: UIImage) -> String? {
        return image.jpegData(compressionQuality: 1)?.base64EncodedString()
    }

}
