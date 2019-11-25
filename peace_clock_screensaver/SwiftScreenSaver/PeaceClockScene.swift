//
//  DotsScene.view.swift
//  SwiftScreenSaver
//
//  Created by Eric Li on 8/21/19.
//  Copyright © Eric Li. All rights reserved.
//

import SpriteKit
import Cocoa

class PeaceClockScene: SKScene {
    let debug = false
    
    var w : CGFloat = 0
    var h : CGFloat = 0
    var midX : CGFloat = 0
    var midY : CGFloat = 0
    
    let widthFactor : CGFloat = 0.055
    let strokeColor : SKColor = .white
    var r : CGFloat = 0.0
    
    var hLine : SKShapeNode = SKShapeNode()
    var mLine : SKShapeNode = SKShapeNode()
    var sLine : SKShapeNode = SKShapeNode()
    
    
    override var acceptsFirstResponder: Bool { return false }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.w = size.width
        self.h = size.height
        
        let minWH = min(self.w, self.h)
        self.midX = self.w/2.0
        self.midY = self.h/2.0
        
        let d = minWH * 0.8
        self.r = d * 0.5
        
        let strokeWidth = minWH * self.widthFactor
        
        let circle = SKShapeNode(circleOfRadius: self.r)
        circle.position = CGPoint(x: midX, y: midY)
        circle.fillColor = .clear
        circle.strokeColor = self.strokeColor
        circle.lineWidth = strokeWidth + 2
        self.addChild(circle)
        
        let verticalLine = SKShapeNode()
        let verticalLinePath = CGMutablePath.init()
        verticalLinePath.move(to: CGPoint(x: midX, y: midY - self.r))
        verticalLinePath.addLine(to: CGPoint(x: midX, y: midY + self.r))
        verticalLine.path = verticalLinePath
        verticalLine.fillColor = .clear
        verticalLine.strokeColor = self.strokeColor
        verticalLine.lineWidth = strokeWidth + 2
        self.addChild(verticalLine)
        
        self.hLine = SKShapeNode()
        hLine.fillColor = .clear
        hLine.strokeColor = self.strokeColor
        hLine.lineWidth = strokeWidth
        hLine.lineCap = .round
        self.addChild(hLine)
        
        self.mLine = SKShapeNode()
        mLine.fillColor = .clear
        mLine.strokeColor = self.strokeColor
        mLine.lineWidth = strokeWidth
        mLine.lineCap = .round
        self.addChild(mLine)
        
        self.sLine = SKShapeNode()
        sLine.fillColor = .clear
        sLine.strokeColor = self.strokeColor
        sLine.lineWidth = 2
        sLine.lineCap = .round
        self.addChild(sLine)
        
        if (self.debug) {
            hLine.strokeColor = .magenta
            mLine.strokeColor = .green
            sLine.strokeColor = .cyan
        }
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didMove(to view: SKView) {
        self.resignFirstResponder()
        self.isUserInteractionEnabled=false
    }
    
    override func update(_ currentTime: TimeInterval) {
        let date = Date()
        let calendar = Calendar.current
        let h = calendar.component(.hour, from: date) % 12
        let m = calendar.component(.minute, from: date)
        let s = calendar.component(.second, from: date)

        let ha = map(value: CGFloat(h) + (CGFloat(m) / 60.0), in_min: 0.0, in_max: 12.0, out_min: 0.0, out_max: 2.0 * .pi) - (0.5 * .pi)
        let ma = map(value: CGFloat(m) + (CGFloat(s) / 60.0), in_min: 0.0, in_max: 60.0, out_min: 0.0, out_max: 2.0 * .pi) - (0.5 * .pi)
        let sa = map(value: CGFloat(s), in_min: 0.0, in_max: 60.0, out_min: 0.0, out_max: 2.0 * .pi) - (0.5 * .pi)
        

        let hLinePath = CGMutablePath.init()
        hLinePath.move(to: CGPoint(x: self.midX, y: self.midY))
        hLinePath.addLine(to: CGPoint(x: (cos(ha) * self.r) + self.midX, y: (sin(ha) * -1 * self.r) + self.midY))
        self.hLine.path = hLinePath
        
        let mLinePath = CGMutablePath.init()
        mLinePath.move(to: CGPoint(x: self.midX, y: self.midY))
        mLinePath.addLine(to: CGPoint(x: (cos(ma) * self.r) + self.midX, y: (sin(ma) * -1 * self.r) + self.midY))
        self.mLine.path = mLinePath
        
        let sLinePath = CGMutablePath.init()
        sLinePath.move(to: CGPoint(x: self.midX, y: self.midY))
        sLinePath.addLine(to: CGPoint(x: (cos(sa) * self.r) + self.midX, y: (sin(sa) * -1 * self.r) + self.midY))
        self.sLine.path = sLinePath
    }

    
    func map(value:CGFloat, in_min:CGFloat, in_max:CGFloat, out_min:CGFloat, out_max:CGFloat) -> CGFloat {
        return (value - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
    }
}
