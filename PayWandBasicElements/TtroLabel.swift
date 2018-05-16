//
//  TtroLabel.swift
//  PayWandDemo
//
//  Created by Farid on 8/10/16.
//  Copyright © 2016 Farid. All rights reserved.
//

import UIKit

public class TtroLabel: UILabel {
    
    var mainFont : UIFont!
    
    public convenience init(font : UIFont, color : UIColor) {
        self.init(frame : CGRect.zero)
        textColor = color
        self.font = font
        mainFont = font
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var text: String? {
//        didSet {
//            if (mainFont == nil){
//                return
//            }
//            if text?.rangeOfString(AppData.sharedInstance.currencySimbolList[1]) != nil {
//                
//                //text?.insert(" ", atIndex: text!.rangeOfString("آ")!.endIndex)
//                let nsText = text! as NSString
//                let textRange = NSMakeRange(0, nsText.length)
//                let attributedString = NSMutableAttributedString(string: text!)
//                
////                let index = text?.rangeOfString(AppData.sharedInstance.currencySimbolList[1])!
////                let nsRange = NSMakeRange(index?.startIndex., index?.
//                
//                nsText.enumerateSubstringsInRange(textRange, options: .ByComposedCharacterSequences, usingBlock: {
//                    (substring, substringRange, _, _) in
//                    if (substring == AppData.sharedInstance.currencySimbolList[1]) {
//                        attributedString.addAttribute(NSFontAttributeName, value: UIFont.ttroFonts.AdobeArabic(size: self.mainFont.pointSize).font, range: substringRange)
//                    }
//                })
//                self.attributedText = attributedString
//                
//            }
//        }
//    }
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}



import CoreGraphics
import CoreText

//extension NSAttributedStringKey {
//
//}

public class HighlightTextView: UIView {
    
    public static let HighLightColorAttribute = "HighLightColorAttribute"
    public static let highlightColorAttribute : NSAttributedStringKey = NSAttributedStringKey(rawValue: "HighLightColorAttribute")
    
//    public var text : NSAttributedString = {
//        var att = [NSFontAttributeName:UIFont(name:"Helvetica", size:14)!]
//        var text = NSMutableAttributedString(string: "normal vs highlited ", attributes:att)
//        text.append(NSAttributedString(string: "Your account is being approved, please be patient", attributes:  [HighlightTextView.HighLightColorAttribute:UIColor.TtroColors.orange.color, NSFontAttributeName:UIFont(name:"Helvetica", size:14)!]))
//        text.append(NSAttributedString(string: " text ", attributes:att))
//        return text
//    }()
    
    var _text : NSAttributedString!
    
    public var text : NSAttributedString {
        get {
            return _text
        }
        set {
            _text = newValue
            setNeedsDisplay()
        }
    }
    
    public var cornerRadius : CGFloat = 4
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        let frameSetter = CTFramesetterCreateWithAttributedString(_text)
        let framePath = CGMutablePath()
        framePath.addRect(self.bounds.insetBy(dx: cornerRadius/2, dy: cornerRadius/2))
        let ctFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), framePath, nil)
        let ctx = UIGraphicsGetCurrentContext()!
        ctx.saveGState()
        
        ctx.textMatrix = .identity
        ctx.translateBy(x: 0, y: bounds.height)
        ctx.scaleBy(x: 1.0, y: -1.0)
        
        
        let lines : NSArray = CTFrameGetLines(ctFrame)
        var lineOrigins : [CGPoint] = [CGPoint](repeating: .zero, count : lines.count)
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &lineOrigins)
        
        for lineIndex in 0 ..< lines.count {
            let line = lines[lineIndex] as! CTLine
            let lineOrigin = lineOrigins[lineIndex]
            
            let runs:NSArray = CTLineGetGlyphRuns(line)
            for run : CTRun in runs as! [CTRun] {
                let stringRange = CTRunGetStringRange(run)
                var ascent : CGFloat = 0
                var descent : CGFloat = 0
                var leading : CGFloat = 0
                let typographicBounds = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, &leading)
                let xOffset : CGFloat = CTLineGetOffsetForStringIndex(line, stringRange.location, nil)
                ctx.textPosition = CGPoint(x: lineOrigin.x + cornerRadius/2 , y: lineOrigin.y + descent - 5)
                
                
                let runBounds = CGRect(x: lineOrigin.x + xOffset , y: lineOrigin.y - cornerRadius/4 - 5, width: CGFloat(typographicBounds) + cornerRadius, height: ascent + descent + cornerRadius/2)
                let attributes: NSDictionary = CTRunGetAttributes(run)
                if let highlightColor = attributes.value(forKey: HighlightTextView.HighLightColorAttribute) as! UIColor? {
                    let path = UIBezierPath(roundedRect: runBounds, cornerRadius: cornerRadius)
                    highlightColor.setFill()
                    path.fill()
                }
                CTRunDraw(run, ctx, CFRangeMake(0, 0))
            }
        }
        ctx.restoreGState()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.clear
    }
}
