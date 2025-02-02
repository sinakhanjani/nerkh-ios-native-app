//
//  Extention+UIImageView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

// Variable downloadQueue: Stores data relevant to this class.let downloadQueue = DispatchQueue(label: "Images cache", qos: DispatchQoS.background)
 
extension UIImageView: RequestImages {
    //MARK: - Fetch image from URL and Imagescache
// Function loadImage: Performs a specific task in the class.    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        downloadQueue.async(execute: { () -> Void in
            do {
// Variable data: Stores data relevant to this class.                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { self.image = image }
                } else { print("Could not decode image") }
            } catch {
                print("Could not load URL: \(url): \(error)")
            }
        })
    }
}

protocol RequestImages {}
extension RequestImages where Self == UIImageView {
// Function requestImage: Performs a specific task in the class.    func requestImage(from url: URL, completion: @escaping (_ _image: UIImage) -> Void) {
        //
    }
}
