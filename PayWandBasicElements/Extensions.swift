//
//  Extensions.swift
//  PayWandBasicElements
//
//  Created by Farid on 12/15/16.
//  Copyright © 2016 ParsPay. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

public protocol TtroColorProtocol {
    var color : UIColor { get }
}

extension UIColor {
    public enum TtroColors : TtroColorProtocol {
        case white
        case darkBlue
        case lightBlue
        case cyan
        case green
        case orange
        case red
        
        public var color: UIColor {
            switch self {
            case .white:
                return UIColor("#f0f0f0")
            case .cyan:
                return UIColor("#50e6b4")
            case .darkBlue:
                return UIColor("#2d3c50")
            case .lightBlue:
                return UIColor("#3296dc")
            case .green:
                return UIColor("#2ecc71")
            case .red:
                return UIColor("#ba293f")
            case .orange:
                return UIColor("#ffa800")
            }
        }
    }
}

public protocol TtroFontProtocol {
    var font : UIFont { get }
}

extension UIFont {
    public enum TtroFonts : TtroFontProtocol {
        case extraLight(size : CGFloat)
        case semibold(size : CGFloat)
        case bold(size : CGFloat)
        case black(size : CGFloat)
        case regular(size : CGFloat)
        case light(size : CGFloat)
        //case BNazanin(size : CGFloat)
        //case AdobeArabic(size : CGFloat)
        
        fileprivate func getFont() -> UIFont {
            switch self {
            case let .black(size):
                return UIFont(name: "SourceSansPro-Black", size: size)!
            case let .bold(size):
                return UIFont(name: "SourceSansPro-Bold", size: size)!
            case let .extraLight(size):
                return UIFont(name: "SourceSansPro-ExtraLight", size: size)!
            case let .light(size):
                return UIFont(name: "SourceSansPro-Light", size: size)!
            case let .regular(size):
                return UIFont(name: "SourceSansPro-Regular", size: size)!
            case let .semibold(size):
                return UIFont(name: "SourceSansPro-Semibold", size: size)!
                //            case let .BNazanin(size):
                //                return UIFont(name: "BNazanin", size: size)!
                //            case let .AdobeArabic(size):
                //                return UIFont(name: "AdobeArabic-Regular", size: size + 4)!
            }
        }
        
        public var font: UIFont {
            return getFont()
        }
    }
    
    public enum TtroPayWandFonts : TtroFontProtocol {
        case semibold1, semibold2
        case regular1, regular2, regular3, regular4, regular5
        case light1, light2, light3, light4, light5
        
        fileprivate func getFont() -> UIFont {
            if (DeviceType.IS_IPAD){
                switch self {
                case .semibold1:
                    return TtroFonts.semibold(size: 20).font
                case .semibold2:
                    return TtroFonts.semibold(size: 40).font
                case .regular1:
                    return TtroFonts.regular(size: 24).font
                case .regular2:
                    return TtroFonts.regular(size: 30).font
                case .regular3:
                    return TtroFonts.regular(size: 36).font
                case .regular4:
                    return TtroFonts.regular(size: 40).font
                case .regular5:
                    return TtroFonts.regular(size: 48).font
                case .light1:
                    return TtroFonts.light(size: 16).font
                case .light2:
                    return TtroFonts.light(size: 20).font
                case .light3:
                    return TtroFonts.light(size: 24).font
                case .light4:
                    return TtroFonts.light(size: 30).font
                case .light5:
                    return TtroFonts.light(size: 36).font
                }
            }
            else if (DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P) {
                switch self {
                case .semibold1:
                    return TtroFonts.semibold(size: 18).font
                case .semibold2:
                    return TtroFonts.semibold(size: 40).font
                case .regular1:
                    return TtroFonts.regular(size: 20).font
                case .regular2:
                    return TtroFonts.regular(size: 24).font
                case .regular3:
                    return TtroFonts.regular(size: 30).font
                case .regular4:
                    return TtroFonts.regular(size: 36).font
                case .regular5:
                    return TtroFonts.regular(size: 44).font
                case .light1:
                    return TtroFonts.light(size: 14).font
                case .light2:
                    return TtroFonts.light(size: 20).font
                case .light3:
                    return TtroFonts.light(size: 24).font
                case .light4:
                    return TtroFonts.light(size: 28).font
                case .light5:
                    return TtroFonts.light(size: 34).font
                }
            }
            else {
                switch self {
                case .semibold1:
                    return TtroFonts.semibold(size: 14).font
                case .semibold2:
                    return TtroFonts.semibold(size: 40).font
                case .regular1:
                    return TtroFonts.regular(size: 16).font
                case .regular2:
                    return TtroFonts.regular(size: 20).font
                case .regular3:
                    return TtroFonts.regular(size: 24).font
                case .regular4:
                    return TtroFonts.regular(size: 30).font
                case .regular5:
                    return TtroFonts.regular(size: 40).font
                case .light1:
                    return TtroFonts.light(size: 12).font
                case .light2:
                    return TtroFonts.light(size: 16).font
                case .light3:
                    return TtroFonts.light(size: 20).font
                case .light4:
                    return TtroFonts.light(size: 24).font
                case .light5:
                    return TtroFonts.light(size: 30).font
                }
            }
        }
        
        public var font: UIFont {
            return getFont()
        }
    }
}

public struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

public struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad || ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}


extension UIImage {
    public func imageWithSize(_ size:CGSize) -> UIImage
    {
        var scaledImageRect = CGRect.zero;
        
        let aspectWidth:CGFloat = size.width / self.size.width;
        let aspectHeight:CGFloat = size.height / self.size.height;
        let aspectRatio:CGFloat = min(aspectWidth, aspectHeight);
        
        scaledImageRect.size.width = self.size.width * aspectRatio;
        scaledImageRect.size.height = self.size.height * aspectRatio;
        scaledImageRect.origin.x = (size.width - scaledImageRect.size.width) / 2.0;
        scaledImageRect.origin.y = (size.height - scaledImageRect.size.height) / 2.0;
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        
        self.draw(in: scaledImageRect);
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return scaledImage!;
    }
    
    struct RotationOptions: OptionSet {
        let rawValue: Int
        
        static let flipOnVerticalAxis = RotationOptions(rawValue: 1)
        static let flipOnHorizontalAxis = RotationOptions(rawValue: 2)
    }
    
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
        let radiansToDegrees: (CGFloat) -> CGFloat = {
            return $0 * (180.0 / CGFloat(M_PI))
        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(M_PI)
        }
        
        // calculate the size of the rotated view's containing box for our drawing space
        let rotatedViewBox = UIView(frame: CGRect(origin: .zero, size: size))
        let t = CGAffineTransform(rotationAngle: degreesToRadians(degrees));
        rotatedViewBox.transform = t
        let rotatedSize = rotatedViewBox.frame.size
        
        // Create the bitmap context
        UIGraphicsBeginImageContext(rotatedSize)
        let bitmap = UIGraphicsGetCurrentContext()
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        bitmap!.translateBy(x: rotatedSize.width / 2.0, y: rotatedSize.height / 2.0);
        
        //   // Rotate the image context
        bitmap!.rotate(by: degreesToRadians(degrees));
        
        // Now, draw the rotated/scaled image into the context
        var yFlip: CGFloat
        
        if(flip){
            yFlip = CGFloat(-1.0)
        } else {
            yFlip = CGFloat(1.0)
        }
        
        bitmap!.scaleBy(x: yFlip, y: -1.0)
//        bitmap!.draw(CGImage, in: CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height))
//        CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage(
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? self
    }
    
    @available(iOS 10.0, *)
    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
        rect.origin = .zero
        
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)
            
            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
            
            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
}

extension CGSize {
    public func scale(_ factor : CGFloat) -> CGSize{
        return CGSize(width: self.width * factor, height: self.height * factor)
    }
}

///

//
//  CAAnimation+Closure.swift
//  CAAnimation+Closures
//
//  Created by Honghao Zhang on 2/5/15.
//  Copyright (c) 2015 Honghao Zhang. All rights reserved.
//

import QuartzCore

/// CAAnimation Delegation class implementation
class CAAnimationDelegateModified: NSObject, CAAnimationDelegate {
    /// start: A block (closure) object to be executed when the animation starts. This block has no return value and takes no argument.
    var start: (() -> Void)?
    
    /// completion: A block (closure) object to be executed when the animation ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished.
    var completion: ((Bool) -> Void)?
    
    /// startTime: animation start date
    fileprivate var startTime: Date!
    fileprivate var animationDuration: TimeInterval!
    fileprivate var animatingTimer: Timer!
    
    /// animating: A block (closure) object to be executed when the animation is animating. This block has no return value and takes a single CGFloat argument that indicates the progress of the animation (From 0 ..< 1)
    var animating: ((CGFloat) -> Void)? {
        willSet {
            if animatingTimer == nil {
                animatingTimer = Timer(timeInterval: 0, target: self, selector: #selector(CAAnimationDelegateModified.animationIsAnimating(_:)), userInfo: nil, repeats: true)
            }
        }
    }
    
    /**
     Called when the animation begins its active duration.
     
     - parameter theAnimation: the animation about to start
     */
    func animationDidStart(_ theAnimation: CAAnimation) {
        start?()
        if animating != nil {
            animationDuration = theAnimation.duration
            startTime = Date()
            RunLoop.current.add(animatingTimer, forMode: RunLoopMode.defaultRunLoopMode)
        }
    }
    
    /**
     Called when the animation completes its active duration or is removed from the object it is attached to.
     
     - parameter theAnimation: the animation about to end
     - parameter finished:     A Boolean value indicates whether or not the animations actually finished.
     */
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        completion?(flag)
        animatingTimer?.invalidate()
    }
    
    /**
     Called when the animation is executing
     
     - parameter timer: timer
     */
    func animationIsAnimating(_ timer: Timer) {
        let progress = CGFloat(Date().timeIntervalSince(startTime) / animationDuration)
        if progress <= 1.0 {
            animating?(progress)
        }
    }
}

public extension CAAnimation {
    /// A block (closure) object to be executed when the animation starts. This block has no return value and takes no argument.
    public var start: (() -> Void)? {
        set {
            if let animationDelegate = delegate as? CAAnimationDelegateModified {
                animationDelegate.start = newValue
            } else {
                let animationDelegate = CAAnimationDelegateModified()
                animationDelegate.start = newValue
                delegate = animationDelegate
            }
        }
        
        get {
            if let animationDelegate = delegate as? CAAnimationDelegateModified {
                return animationDelegate.start
            }
            
            return nil
        }
    }
    
    /// A block (closure) object to be executed when the animation ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished.
    public var completion: ((Bool) -> Void)? {
        set {
            if let animationDelegate = delegate as? CAAnimationDelegateModified {
                animationDelegate.completion = newValue
            } else {
                let animationDelegate = CAAnimationDelegateModified()
                animationDelegate.completion = newValue
                delegate = animationDelegate
            }
        }
        
        get {
            if let animationDelegate = delegate as? CAAnimationDelegateModified {
                return animationDelegate.completion
            }
            
            return nil
        }
    }
    
    /// A block (closure) object to be executed when the animation is animating. This block has no return value and takes a single CGFloat argument that indicates the progress of the animation (From 0 ..< 1)
    public var animating: ((CGFloat) -> Void)? {
        set {
            if let animationDelegate = delegate as? CAAnimationDelegateModified {
                animationDelegate.animating = newValue
            } else {
                let animationDelegate = CAAnimationDelegateModified()
                animationDelegate.animating = newValue
                delegate = animationDelegate
            }
        }
        
        get {
            if let animationDelegate = delegate as? CAAnimationDelegateModified {
                return animationDelegate.animating
            }
            
            return nil
        }
    }
    
    /// Alias to `animating`
    public var progress: ((CGFloat) -> Void)? {
        set {
            animating = newValue
        }
        
        get {
            return animating
        }
    }
}

public extension CALayer {
    /**
     Add the specified animation object to the layer’s render tree. Could provide a completion closure.
     
     - parameter anim:       The animation to be added to the render tree. This object is copied by the render tree, not referenced. Therefore, subsequent modifications to the object are not propagated into the render tree.
     - parameter key:        A string that identifies the animation. Only one animation per unique key is added to the layer. The special key kCATransition is automatically used for transition animations. You may specify nil for this parameter.
     - parameter completion: A block object to be executed when the animation ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. Default value is nil.
     */
    func addAnimation(_ anim: CAAnimation, forKey key: String?, withCompletion completion: ((Bool) -> Void)?) {
        anim.completion = completion
        add(anim, forKey: key)
    }
}
