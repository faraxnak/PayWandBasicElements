//
//  TtroButton.swift
//  PayWandDemo
//
//  Created by Farid on 8/10/16.
//  Copyright © 2016 Farid. All rights reserved.
//

import UIKit
import EasyPeasy
import SwiftyButton

public class TtroButton: UIButton {
    
    var mode = TtroMode.flat
    var corners : UIRectCorner! = [.topLeft , .bottomLeft]
    var radius : CGFloat! = 10
    var color : UIColor = UIColor.TtroColors.cyan.color
    var highlightColor: UIColor = UIColor.TtroColors.cyan.color
    
    public func setMode(mode: UIButton.TtroMode, font: UIFont = UIFont.TtroPayWandFonts.regular2.font) {
        setMode(mode, font: font, color: color)
        self.mode = mode
    }
    
    public convenience init(corners : UIRectCorner, radius : CGFloat, color: UIColor? = nil, highlightColor: UIColor? = nil){
        self.init()
        self.corners = corners
        self.radius = radius
        if color != nil {
            self.color = color!
        }
        if highlightColor != nil {
            self.highlightColor = highlightColor!
        } else {
            self.highlightColor = self.color
        }
    }
    
    public init(){
        super.init(frame: .zero)
        setTitleColor(color.withAlphaComponent(0.5), for: .highlighted)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setCurvature(corners : UIRectCorner, radius : CGFloat){
        self.corners = corners
        self.radius = radius
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if (mode == .fullBorder) {
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
            
            let frameLayer = CAShapeLayer(layer: layer)
            frameLayer.frame = bounds
            frameLayer.path = path.cgPath
            frameLayer.strokeColor = (state == .highlighted) ? highlightColor.cgColor : color.cgColor
            frameLayer.fillColor = nil
            frameLayer.lineWidth = 2
            layer.addSublayer(frameLayer)
        }
    }
    
    public func setBackgroundColor(_ color: UIColor, for state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color), for: state)
    }
    
    func imageWithColor(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            if let cgImage = context.makeImage(){
                UIGraphicsEndImageContext()
                return UIImage(cgImage: cgImage)
            }
            UIGraphicsEndImageContext()
            return nil
        }
        return nil
    }
}

extension UIButton {
    public enum TtroMode {
        case flat
        case pressable
        case backgroundless
        case fullBorder
    }
    public func setMode(_ mode : TtroMode, font : UIFont = UIFont.TtroPayWandFonts.regular2.font, color : UIColor = UIColor.TtroColors.cyan.color) {
        switch mode {
        case .flat:
            layer.cornerRadius = 5
            backgroundColor = UIColor.TtroColors.cyan.color.withAlphaComponent(0.7)
            titleLabel?.font = font
            setTitleColor(UIColor.TtroColors.darkBlue.color, for: UIControlState())
            //titleLabel?.addObserver(self, forKeyPath: "text", options: [.Old, .New], context: nil)
        case .pressable:
            if let sButton = self as? SwiftyButton {
                sButton.shadowColor  = UIColor.TtroColors.darkBlue.color.withAlphaComponent(0.5)
                sButton.shadowHeight = 2
                sButton.cornerRadius = 5
            }
        case .backgroundless:
            titleLabel?.font = font
            setTitleColor(color, for: .normal)
        case .fullBorder:
            titleLabel?.font = font
            setTitleColor(color, for: .normal)
//            layer.borderColor = UIColor.TtroColors.cyan.color.cgColor
//            layer.borderWidth = 1
//            layer.masksToBounds = true
        }
        
    }
    
//    override public func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        if keyPath == "text" {
//            let text = titleLabel?.text
//            if text?.rangeOfString(AppData.sharedInstance.currencySimbolList[1]) != nil {
//                
//                //text?.insert(" ", atIndex: text!.rangeOfString("آ")!.endIndex)
//                let nsText = text! as NSString
//                let textRange = NSMakeRange(0, nsText.length)
//                let attributedString = NSMutableAttributedString(string: text!)
//                
//                nsText.enumerateSubstringsInRange(textRange, options: .ByComposedCharacterSequences, usingBlock: {
//                    (substring, substringRange, _, _) in
//                    print(substring)
//                    print(substringRange)
//                    if (substring == AppData.sharedInstance.currencySimbolList[1]) {
//                        attributedString.addAttribute(NSFontAttributeName, value: UIFont.ttroFonts.AdobeArabic(size: self.titleLabel!.font.pointSize).font, range: substringRange)
//                    }
//                })
//                self.titleLabel?.attributedText = attributedString
//            }
//        }
//    }
}

extension UIButton {
    public func setIconText(_ text : String, image : UIImage?) {
        
//        setImage(image, forState: UIControlState.Normal)
//        
//        setTitle(text, forState: UIControlState.Normal)
//        
//        if image?.size != nil {
//            let d : CGFloat = 5
//            let imageW : CGFloat = 30
//            let offset = (frame.height - imageW)/2
//            print(frame)
//            
//            imageEdgeInsets = UIEdgeInsets(top: offset, left: offset, bottom: offset, right: frame.width - imageW - offset - 10)
//            
//            //titleEdgeInsets = UIEdgeInsets(top: 0,left: 5, bottom: 0,right: 0)
//        }
        
//        setImage(image, forState: UIControlState.Normal)
//        imageView?.translatesAutoresizingMaskIntoConstraints = false
//        imageView?.contentMode = .ScaleAspectFit
//        imageView! <- [
//            Left(0),
//            Top(7.5),
//            Bottom(7.5)
//        ]
        setTitle(text, for: UIControlState())
//        
//        titleLabel?.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel! <- [
//            CenterY(),
//            Left(0).to(imageView!)
//        ]
        titleLabel?.adjustsFontSizeToFitWidth = true
        
        setImage(image, for: UIControlState())
        //imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.contentMode = .scaleAspectFit
        imageView?.removeConstraints(imageView!.constraints)
        imageView! <- [
            Right(0).to(titleLabel!, .left),
            Top(7.5),
            Bottom(7.5)
        ]
        
//        let dummyView = UIView()
//        dummyView.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(dummyView)
//        dummyView <- [
//            Left(),
//            Top(),
//            Right().to(titleLabel!, .Left),
//            Bottom()
//        ]
//        dummyView.backgroundColor = UIColor.orangeColor()
        
        //titleLabel?.textAlignment = .Left
        
//        let imageViewTouchPassing = TouchPassingUIImageView(image: image, parentView: self)
//        imageViewTouchPassing.contentMode = .ScaleAspectFit
//        imageViewTouchPassing.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(imageViewTouchPassing)
//        imageViewTouchPassing <- [
//            Left(5),
//            Top(5),
//            Bottom(5)
//        ]
//        layoutIfNeeded()
//        setTitle(text, forState: UIControlState.Normal)
        
    }
}

public class TouchPassingUIImageView: UIImageView {
    var parentView : UIView!
    
    public convenience init(image: UIImage?, parentView : UIView) {
        self.init(image : image)
        self.parentView = parentView
    }
    
    public override init(image: UIImage?) {
        super.init(image: image)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if (view == self){
            return parentView
        }
        
        return view
    }
}


public class TtroAlertButton: UIButton {
    
    public var action :(() -> Void)?
    
    fileprivate func actionHandleBlock(_ action:(() -> Void)? = nil) {
        
        if action != nil {
            self.action = action
        } else {
            self.action?()
        }
    }
    
    @objc fileprivate func triggerActionHandleBlock() {
        self.actionHandleBlock()
    }
    
    public func actionHandle(controlEvents control :UIControlEvents, ForAction action:@escaping () -> Void) {
        self.actionHandleBlock(action)
        self.addTarget(self, action: #selector(triggerActionHandleBlock), for: control)
    }
}
