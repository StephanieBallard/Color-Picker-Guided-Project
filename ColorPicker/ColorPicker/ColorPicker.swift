//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Stephanie Ballard on 4/16/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import UIKit

@IBDesignable
class ColorPicker: UIControl {

    // MARK: - Properties -
    var colorWheel = ColorWheel()
    var brightnessSlider = UISlider()
    var color: UIColor = .white

    // MARK: - Initializers -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubviews()
    }
    
    // MARK: - View Lifecycle -
    
    func setUpSubviews() {
        backgroundColor = .clear
    
    
    // MARK: - Color Wheel -
    colorWheel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(colorWheel)
        
    NSLayoutConstraint.activate([
        colorWheel.topAnchor.constraint(equalTo: topAnchor),
        colorWheel.leadingAnchor.constraint(equalTo: leadingAnchor),
        colorWheel.trailingAnchor.constraint(equalTo: trailingAnchor),
        colorWheel.heightAnchor.constraint(equalTo: colorWheel.widthAnchor)
    ])
        
        // MARK: - Brightness Slider -
        brightnessSlider.maximumValue = 0
        brightnessSlider.maximumValue = 1
        brightnessSlider.value = 0.8
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        brightnessSlider.addTarget(self, action: #selector(changeBrightness), for: .valueChanged)
        addSubview(brightnessSlider)
        
        NSLayoutConstraint.activate([
            brightnessSlider.topAnchor.constraint(equalTo: colorWheel.bottomAnchor, constant: 8),
            brightnessSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            brightnessSlider.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
}
    
    @objc func changeBrightness() {
        colorWheel.brightness = CGFloat(brightnessSlider.value)
    }
    
    // MARK: - Touch Tracking -
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        color = colorWheel.color(for: touchPoint)
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpInside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
}
