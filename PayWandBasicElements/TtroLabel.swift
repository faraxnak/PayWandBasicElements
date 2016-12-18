//
//  TtroLabel.swift
//  PayWandDemo
//
//  Created by Farid on 8/10/16.
//  Copyright © 2016 Farid. All rights reserved.
//

import UIKit

class TtroLabel: UILabel {
    
    var mainFont : UIFont!
    
    convenience init(font : UIFont, color : UIColor) {
        self.init(frame : CGRect.zero)
        textColor = color
        self.font = font
        mainFont = font
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
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

extension String {
    func widthWithConstrainedWidth(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
    }
}
