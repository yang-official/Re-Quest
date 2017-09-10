//
//  TabBarItemView.swift
//  ReQuest_ios
//
//  Created by Leon Mak on 9/9/17.
//  Copyright © 2017 Leon Mak. All rights reserved.
//

import UIKit
import ChameleonFramework
import ESTabBarController_swift

class TabBarItemView: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        iconColor = UIColor.flatBlue
        highlightIconColor = UIColor.flatSkyBlue
        textColor = UIColor.flatSkyBlueDark
        highlightTextColor = UIColor.flatSkyBlue
    }
    
    func jingleAnimation() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0 ,1.5, 0.6, 1.18, 0.9, 1.2, 1.0]
        animation.duration = 0.9
        animation.calculationMode = kCAAnimationCubic
        imageView.layer.add(animation, forKey: nil)
    }
    
    override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        self.jingleAnimation()
        completion?()
    }
    
    override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        self.jingleAnimation()
        completion?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
