//
//  ImageManager.swift
//  BusyBoss
//
//  Created by Yafet Sutanto on 21/11/20.
//

import Foundation
import UIKit
import CloudKit

class ImageManager {
    
    static public func convertToUIImage(file: CKAsset?) -> UIImage? {
        if let file = file {
            if let data = NSData(contentsOf: file.fileURL!) {
                return UIImage(data: data as Data)
            }
        }
        return nil
    }
    
    static public func convertToCKAsset(image: UIImage) -> CKAsset?{
        let data = image.pngData();
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")!
        do {
            try data!.write(to: url)
        } catch let e as NSError {
            print("Error! \(e.localizedDescription)");
        }
        return CKAsset(fileURL: url)
    }
}
