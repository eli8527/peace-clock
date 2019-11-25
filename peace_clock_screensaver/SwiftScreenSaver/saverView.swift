//
//  saverView.swift
//

//  Created by Eric Li on 1/23/19.
//  Copyright © 2019 Eric Li. All rights reserved.
//
//  http://blog.viacom.tech/2016/06/27/making-a-macos-screen-saver-in-swift-with-scenekit/
//

import ScreenSaver
import SpriteKit

class saverView: ScreenSaverView {
    
    var spriteView: SpriteScreenSaverView?
    
    override init?(frame: NSRect, isPreview: Bool) {
        
        super.init(frame: frame, isPreview: isPreview)
        self.animationTimeInterval = 1.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.animationTimeInterval = 1.0
    }
    
    override var frame: NSRect {
        didSet
        {
            self.spriteView?.frame = frame
        }
    }
    
    override func startAnimation() {
        if self.spriteView == nil {
            let spriteView = SpriteScreenSaverView(frame: self.frame)
            
            //initialize the spriteKit view
            let scene = PeaceClockScene(size: spriteView.frame.size)
            scene.backgroundColor = .black

            // add it in as a subview
            // spriteView.showsFPS = true
            // spriteView.showsNodeCount = true
            spriteView.presentScene(scene)
            self.addSubview(spriteView)
        }
        super.startAnimation()
    }

}
