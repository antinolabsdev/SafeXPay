//
//  UITextField.swift
//  SafexPay
//
//  Created by Sandeep on 8/7/20.
//  Copyright © 2020 Antino Labs. All rights reserved.
//

import UIKit

@IBDesignable
class UnderLineImageTextField: UITextField {
    override func drawRect(rect: CGRect) {
        
        let borderLayer = CALayer()
        let widthOfBorder = getBorderWidht()
        borderLayer.frame = CGRectMake(-15, self.frame.size.height - widthOfBorder, self.frame.size.width+20, self.frame.size.height)
        borderLayer.borderWidth = widthOfBorder
        borderLayer.borderColor = getBottomLineColor()
        self.layer.addSublayer(borderLayer)
        self.layer.masksToBounds = true
        
    }
    
    
    
    //MARK : set the image LeftSide
    @IBInspectable var SideImage:UIImage? {
        didSet{
            
            let leftAddView = UIView.init(frame: CGRectMake(0, 0, 25, self.frame.size.height-10))
            let leftimageView = UIImageView.init(frame: CGRectMake(0, 0, 20, 20))//Create a imageView for left side.
            leftimageView.image = SideImage
            leftAddView.addSubview(leftimageView)
            self.leftView = leftAddView
            self.leftViewMode = UITextFieldViewMode.Always
        }
        
    }
    @IBInspectable var bottomLineColor: UIColor = UIColor.blackColor() {
        didSet {
            
        }
    }
    
    
    func getBottomLineColor() -> CGColor {
        return bottomLineColor.CGColor;
        
    }
    @IBInspectable var cusborderWidth:CGFloat = 1.0
        {
        didSet{
            
        }
    }
    
    func getBorderWidht() -> CGFloat {
        return cusborderWidth;
        
    }
}
