//
//  DraggableImageView.swift
//  Tinder
//
//  Created by Christian Deonier on 3/2/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class DraggableImageView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var originalCenterPoint : CGPoint?
    
    var imageCenterPoint: CGPoint?
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "DraggableImageView", bundle: nil)
        nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        originalCenterPoint = self.center
        addSubview(contentView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }

    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat(M_PI)
        let rotation = CGAffineTransformRotate(self.transform, radians);
        self.transform = rotation
    }
    
    func translateSelf(view: UIView, gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(view)
        
        if gesture.state == UIGestureRecognizerState.Began {
            imageCenterPoint = self.center
        } else if gesture.state == UIGestureRecognizerState.Changed {
            
            self.transform = CGAffineTransformIdentity
            
            
            // Moving left
            if(translation.x < 0){
                rotate(270)
            }
            // Moving right
            else {
                rotate(90)
            }
            
            let tempCenter = CGPoint(x: translation.x + imageCenterPoint!.x, y: imageCenterPoint!.y)
            self.center = tempCenter
            
        } else if gesture.state == UIGestureRecognizerState.Ended {
            
            imageCenterPoint = CGPoint(x: translation.x + imageCenterPoint!.x, y: imageCenterPoint!.y)
            
            // Moving off screen logic
            if(imageCenterPoint!.x + translation.x > imageCenterPoint!.x + 50){

                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.center = CGPoint(x: 1000, y: self.imageCenterPoint!.y)
                })
            }
            else if(imageCenterPoint!.x + translation.x < imageCenterPoint!.x - 50){

                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.center = CGPoint(x: -1000, y: self.imageCenterPoint!.y)
                })
            }
            else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.center = self.originalCenterPoint!
                })
            }
            
            
            
        } else {
            //??
        }
    }
}
