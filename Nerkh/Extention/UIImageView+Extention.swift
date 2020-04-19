//
//  Extention+UIImageView.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

let downloadQueue = DispatchQueue(label: "Images cache", qos: DispatchQoS.background)
 
extension UIImageView: RequestImages {
    //MARK: - Fetch image from URL and Imagescache
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        downloadQueue.async(execute: { () -> Void in
            do {
                let data = try Data(contentsOf: url)
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
    func requestImage(from url: URL, completion: @escaping (_ _image: UIImage) -> Void) {
        //
    }
}
