//
//  UIViewDraw.swift
//  Signature
//
//  Created by Yafet Sutanto on 05/12/20.
//

import Foundation
import UIKit

class UIViewDraw : UIView {
    
    struct Line {
        let isContinousLine:Bool
        let coordinate:CGPoint
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else
        { return }
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        for (i,line) in lines.enumerated(){
            if !line.isContinousLine {
                context.move(to: line.coordinate)
            } else {
                context.addLine(to: line.coordinate)
            }
        }
        
        context.strokePath()
    }
    
    var lines = [Line]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        let newLine = Line(isContinousLine: false, coordinate: point)
        lines.append(newLine)
        setNeedsDisplay()
    }
    
    //track the finger as we move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else { return }
        
        let newLine = Line(isContinousLine: true, coordinate: point)
        lines.append(newLine)
        setNeedsDisplay()
    }
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(self.frame.size)
            self.layer.render(in:UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return UIImage(cgImage: image!.cgImage!)
        }
    }
}


