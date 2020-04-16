//
//  ColorWheel.swift
//  ColorPicker
//
//  Created by Stephanie Ballard on 4/16/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

class ColorWheel: UIView {
    
    var brightness: CGFloat = 0.8 {
        didSet {
            setNeedsDisplay()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //backgroundColor = .purple
        
        isUserInteractionEnabled = false
        clipsToBounds = true
        
        let radius = frame.width / 2.0
        layer.cornerRadius = radius
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let size: CGFloat = 1
        
        for y in stride(from: 0, to: bounds.maxY, by: size) {
            for x in stride(from: 0, to: bounds.maxX, by: size) {
                let color = self.color(for: CGPoint(x: x, y: y))
                let square = CGRect(x: x, y: y, width: size, height: size)
                
                color.set()
                UIRectFill(square)
            }
        }
    
    }
    
    func color(for location: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        // dy = distance y
        let dy = location.y - center.y
        let dx = location.x - center.x
        let offset = CGPoint(x: dx / center.x, y: dy / center.y)
        let (hue, saturation) = getHueSaturation(at: offset)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    // hue degree on the color wheel 0 to 360
    // saturation how red is the red, how orange is the orange, how vibrant or how washed out is the color
    // brightness is how dark the color is, in this case user is picking by the slider
    func getHueSaturation(at offset: CGPoint) -> (hue: CGFloat, saturation: CGFloat) {
        if offset == CGPoint.zero {
            return (hue: 0, saturation: 0)
        } else {
            // the further away from the center, the more saturated the color
            let saturation = sqrt(offset.x * offset.x + offset.y * offset.y)
            // the offset angle is determined to figure out what hue to use within the full spectrum
            var hue = acos(offset.x / saturation) / (2.0 * .pi)
            if offset.y < 0 { hue = 1.0 - hue }
            return (hue: hue, saturation: saturation)
        }
    }
    
    
}
