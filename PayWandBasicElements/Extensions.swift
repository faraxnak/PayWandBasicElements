//
//  Extensions.swift
//  PayWandBasicElements
//
//  Created by Farid on 12/15/16.
//  Copyright © 2016 ParsPay. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift
import PayWandModelProtocols
import SwifterSwift

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
                if Locale.current.languageCode == "ar" {
//                    return UIFont(name: "Dubai-Light", size: size)!
                    return UIFont(name: "Dubai-Light", size: size)!
                } else {
                    return UIFont(name: "SourceSansPro-Light", size: size)!
                }
            case let .regular(size):
                if Locale.current.languageCode == "ar" {
//                    return UIFont(name: "Dubai-Regular", size: size)!
                    return UIFont(name: "Dubai-Regular", size: size)!
                } else {
                    return UIFont(name: "SourceSansPro-Regular", size: size)!
                }
            case let .semibold(size):
                if Locale.current.languageCode == "ar" {
//                    return UIFont(name: "Dubai-Regular", size: size)!
                    return UIFont(name: "Dubai-Regular", size: size)!
                } else {
                    return UIFont(name: "SourceSansPro-Semibold", size: size)!
                }
                
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
    
//    func getSizeiPad(font: TtroPayWandFonts) -> CGFloat {
//
//        switch font {
//        case .semibold1:
//            return isArabic ? 30 : 20
//        case .semibold2:
//            return isArabic ? 50 : 40
//        case .regular1:
//            return isArabic ? 36 : 24
//        case .regular2:
//            return isArabic ? 40 : 30
//        case .regular3:
//            return isArabic ? 48 : 36
//        case .regular4:
//            return isArabic ? 50 : 40
//        case .regular5:
//            return isArabic ? 60 : 48
//        case .light1:
//            return isArabic ? 28 : 16
//        case .light2:
//            return isArabic ? 30 : 20
//        case .light3:
//            return isArabic ? 36 : 20
//        case .light4:
//            return isArabic ? 40 : 30
//        case .light5:
//            return isArabic ? 48 : 36
//        case .light6:
//            return isArabic ? 50 : 42
//        }
//    }
    
    
    
    public enum TtroPayWandFonts : TtroFontProtocol {
        case semibold1, semibold2
        case regular1, regular2, regular3, regular4, regular5
        case light1, light2, light3, light4, light5, light6
        
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
                case .light6:
                    return TtroFonts.light(size: 42).font
                }
            }
            else if (DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P) {
                let size = getSizeiPhone6()
                switch self {
                case .semibold1:
                    return TtroFonts.semibold(size: size).font
                case .semibold2:
                    return TtroFonts.semibold(size: size).font
                case .regular1:
                    return TtroFonts.regular(size: size).font
                case .regular2:
                    return TtroFonts.regular(size: size).font
                case .regular3:
                    return TtroFonts.regular(size: size).font
                case .regular4:
                    return TtroFonts.regular(size: size).font
                case .regular5:
                    return TtroFonts.regular(size: size).font
                case .light1:
                    return TtroFonts.light(size: size).font
                case .light2:
                    return TtroFonts.light(size: size).font
                case .light3:
                    return TtroFonts.light(size: size).font
                case .light4:
                    return TtroFonts.light(size: size).font
                case .light5:
                    return TtroFonts.light(size: size).font
                case .light6:
                    return TtroFonts.light(size: size).font
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
                case .light6:
                    return TtroFonts.light(size: 36).font
                }
            }
        }
        
        public var font: UIFont {
            return getFont()
        }
        
        var isArabic : Bool {
            get {
                return false
//                return Locale.current.languageCode == "ar"
            }
        }
        
        func getSizeiPhone6() -> CGFloat {
            switch self {
            case .semibold1:
                return isArabic ? 30 : 18
            case .semibold2:
                return isArabic ? 50 : 40
            case .regular1:
                return isArabic ? 30 : 19
            case .regular2:
                return isArabic ? 36 : 24
            case .regular3:
                return isArabic ? 40 : 30
            case .regular4:
                return isArabic ? 48 : 36
            case .regular5:
                return isArabic ? 54 : 44
            case .light1:
                return isArabic ? 24 : 14
            case .light2:
                return isArabic ? 30 : 20
            case .light3:
                return isArabic ? 36 : 24
            case .light4:
                return isArabic ? 40 : 28
            case .light5:
                return isArabic ? 44 : 34
            case .light6:
                return isArabic ? 50 : 40
            }
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
    public static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    public static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    public static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    public static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    public static let IS_IPHONE_X          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH > 800.0
    public static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad || ScreenSize.SCREEN_MAX_LENGTH == 1024.0
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
    
    public struct RotationOptions: OptionSet {
        public let rawValue: Int
        
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
        
        public static let flipOnVerticalAxis = RotationOptions(rawValue: 1)
        public static let flipOnHorizontalAxis = RotationOptions(rawValue: 2)
    }
    
    public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
//        let radiansToDegrees: (CGFloat) -> CGFloat = {
//            return $0 * (180.0 / CGFloat(Double.pi))
//        }
        let degreesToRadians: (CGFloat) -> CGFloat = {
            return $0 / 180.0 * CGFloat(Double.pi)
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
    
//    @available(iOS 10.0, *)
//    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage? {
//        guard let cgImage = self.cgImage else { return nil }
//        
//        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
//        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
//        var rect = CGRect(origin: .zero, size: self.size).applying(transform)
//        rect.origin = .zero
//        
//        let renderer = UIGraphicsImageRenderer(size: rect.size)
//        return renderer.image { renderContext in
//            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
//            renderContext.cgContext.rotate(by: rotationInRadians)
//            
//            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
//            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
//            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
//            
//            let drawRect = CGRect(origin: CGPoint(x: -self.size.width/2, y: -self.size.height/2), size: self.size)
//            renderContext.cgContext.draw(cgImage, in: drawRect)
//        }
//    }
}

extension UIImageView {
    public func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
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
    @objc func animationIsAnimating(_ timer: Timer) {
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

public extension UIScrollView {
    
    // Scroll to a specific view so that it's top is at the top our scrollview
    public func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
            self.scrollRectToVisible(CGRect(x: 0, y: childStartPoint.y, width: 1, height: self.frame.height), animated: animated)
        }
    }
    
//    public func scrollToTop(animated: Bool) {
//        let topOffset = CGPoint(x: 0, y: -contentInset.top)
//        setContentOffset(topOffset, animated: animated)
//    }
    
    public func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
}

public extension Double {
    /// Rounds the double to decimal places value
    public func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    public func toString(currency: CurrencyP?) -> String{
        return String.localizedStringWithFormatForCurrency("%C", currency: currency, self)
    }
}


public extension String {
    
    public static func localizedStringWithFormatForCurrency(_ format: String, currency: CurrencyP?,_ arguments: CVarArg...) -> String{
//        let modifiedFormat = format
        let string = withVaList(arguments) { (params) -> String in
            if currency?.title == "IRR" {
                return NSString(format: format.replacingOccurrences(of: "%C", with: "%.0f"), locale: Locale.current, arguments: params) as String
//                return String.localizedStringWithFormat(format.replacingOccurrences(of: "%C", with: "%.0f"), params)
            } else {
                return NSString(format: format.replacingOccurrences(of: "%C", with: "%.2f"), locale: Locale.current, arguments: params) as String
//                return String.localizedStringWithFormat(format.replacingOccurrences(of: "%C", with: "%.2f"), params)
            }
        }
        return string
    }
    
    public func widthWithConstrainedWidth(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width
    }
}

public extension Collection {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safee index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension UIImage {
    func rotated(by rotationAngle: Measurement<UnitAngle>, options: RotationOptions = []) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        
        let rotationInRadians = CGFloat(rotationAngle.converted(to: .radians).value)
        let transform = CGAffineTransform(rotationAngle: rotationInRadians)
        var rect = CGRect(origin: .zero, size: size).applying(transform)
        rect.origin = .zero
        
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { renderContext in
            renderContext.cgContext.translateBy(x: rect.midX, y: rect.midY)
            renderContext.cgContext.rotate(by: rotationInRadians)
            
            let x = options.contains(.flipOnVerticalAxis) ? -1.0 : 1.0
            let y = options.contains(.flipOnHorizontalAxis) ? 1.0 : -1.0
            renderContext.cgContext.scaleBy(x: CGFloat(x), y: CGFloat(y))
            
            let drawRect = CGRect(origin: CGPoint(x: -size.width/2, y: -size.height/2), size: size)
            renderContext.cgContext.draw(cgImage, in: drawRect)
        }
    }
    
    func resize(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / size.width
        let newHeight = size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

//extension UIView {
//    /// SwifterSwift: Check if view is in RTL format.
//    public var isRightToLeft: Bool {
//        if #available(iOS 10.0, *, tvOS 10.0, *) {
//            return effectiveUserInterfaceLayoutDirection == .rightToLeft
//        } else {
//            return false
//        }
//    }
//}

//extension String {
//    public var isEmailTtro: Bool {
//        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
//        return range(of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
//                     options: .regularExpression, range: nil, locale: nil) != nil
//    }
//}
