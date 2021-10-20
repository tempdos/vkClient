//
//  animateDot.swift
//  vkClient
//
//  Created by Василий Слепцов on 26.08.2021.
//

import UIKit


class AnimateDot: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setStrokeColor(UIColor.green.cgColor)
        context.move(to: CGPoint(x: 0, y: 25))
        context.addEllipse(in: CGRect(x: 0, y: 15, width: 20, height: 20))
        context.setFillColor(red: 50, green: 50, blue: 50, alpha: 1)
        context.closePath()
        context.strokePath()
    }
}
