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

extension UIButton {
    enum TtroMode {
        case flat
        case pressable
        case backgroundless
    }
    func setMode(_ mode : TtroMode, font : UIFont = UIFont.ttroPayWandFonts.regular2.font) {
        switch mode {
        case .flat:
            layer.cornerRadius = 5
            backgroundColor = UIColor.ttroColors.cyan.color.withAlphaComponent(0.7)
            titleLabel?.font = font
            setTitleColor(UIColor.ttroColors.darkBlue.color, for: UIControlState())
            //titleLabel?.addObserver(self, forKeyPath: "text", options: [.Old, .New], context: nil)
        case .pressable:
            if let sButton = self as? SwiftyButton {
                sButton.shadowColor  = UIColor.ttroColors.darkBlue.color.withAlphaComponent(0.5)
                sButton.shadowHeight = 2
                sButton.cornerRadius = 5
            }
        case .backgroundless:
            titleLabel?.font = font
            
            setTitleColor(UIColor.ttroColors.cyan.color, for: UIControlState())
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
    func setIconText(_ text : String, image : UIImage?) {
        
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

class TouchPassingUIImageView: UIImageView {
    var parentView : UIView!
    
    convenience init(image: UIImage?, parentView : UIView) {
        self.init(image : image)
        self.parentView = parentView
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        
        if (view == self){
            return parentView
        }
        
        return view
    }
}


class TtroAlertButton: UIButton {
    
    var action :(() -> Void)?
    
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
    
    func actionHandle(controlEvents control :UIControlEvents, ForAction action:@escaping () -> Void) {
        self.actionHandleBlock(action)
        self.addTarget(self, action: #selector(triggerActionHandleBlock), for: control)
    }
}
