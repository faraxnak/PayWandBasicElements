//
//  PinEntry.swift
//  RadiusBlurMenu
//
//  Created by Farid on 7/31/16.
//  Copyright © 2016 Farid. All rights reserved.
//

import UIKit

@objc public protocol TtroDigitEntryDelegate: UITextFieldDelegate {
    
    @objc optional func pinCompleted()
    
    @objc optional func onClearText()
}

public class TtroDigitEntry: UITextField, UITextFieldDelegate {
    
    
    public var nextTextField : TtroDigitEntry?
    public var previousTextField : TtroDigitEntry?
    
    public weak var pinDelegate : TtroDigitEntryDelegate!
    
    public var numOfDigits = 1
    
    public var defaultChar = "_"
    
    public enum Mode {
        case light
        case dark
    }
    
    public var plainText : String? = ""
    public var shouldHideText = false
    
    public convenience init(next : TtroDigitEntry?, previous : TtroDigitEntry?, defaultChar : String = "_", mode : Mode = .light, shouldHideText : Bool = false){
        self.init(frame : CGRect.zero)
        self.nextTextField = next
        self.previousTextField = previous
        self.translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        NotificationCenter.default.addObserver(self, selector: #selector(self.textChanged(_:)), name:NSNotification.Name.UITextFieldTextDidChange, object: self)
        delegate = self
        keyboardType = .numberPad
        layer.cornerRadius = 5
        layer.masksToBounds = true
        switch mode {
        case .light:
            textColor = UIColor.TtroColors.white.color
            self.backgroundColor = UIColor.TtroColors.white.color.withAlphaComponent(0.2)
        case .dark:
            textColor = UIColor.TtroColors.darkBlue.color
            self.backgroundColor = UIColor.TtroColors.darkBlue.color.withAlphaComponent(0.2)
        }
        
        font = UIFont.TtroFonts.regular(size: 20).font
        text = defaultChar
        self.defaultChar = defaultChar
        self.shouldHideText = shouldHideText
        
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let chars = "0123456789●"
        let cSet = CharacterSet(charactersIn: chars + defaultChar)
        let inverseSet = cSet.inverted
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let components = string.arabicEnglishDigitsTranslation().components(separatedBy: inverseSet)
        
        // Rejoin these components
        let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        if (string.arabicEnglishDigitsTranslation() != filtered){
            return false
        }
        
        if (string != ""){
            if ((text ?? "").contains(defaultChar)){
                text = String(text!.filter { chars.contains($0) })
//                text = ""
            } else if (text?.count) ?? -1 > numOfDigits {
                let str = text!
                let index = str.index(str.startIndex, offsetBy: numOfDigits)
                text = String(str[..<index])
            } else if text?.count == numOfDigits {
                if (nextTextField != nil){
                    nextTextField?.becomeFirstResponder()
                    
                } else {
                    return false
                }
            }
//            } else {
//                if (nextTextField != nil){
//                    nextTextField?.text = ""
//                    nextTextField?.becomeFirstResponder()
//                } else {
//                    return false
//                }
//            }
            
        } else {
            pinDelegate.onClearText?()
        }
        //print("here \(text)")
        
        
        return true
    }
    
    @objc public func textFieldDidChange(_ textField: UITextField) {
        textField.text = text?.arabicEnglishDigitsTranslation()
        if textField.text?.count == numOfDigits {
            if (nextTextField != nil){
                nextTextField?.becomeFirstResponder()
            }
        }
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (previousTextField?.text == defaultChar){
            previousTextField?.becomeFirstResponder()
            return false
        }
        return pinDelegate.textFieldShouldBeginEditing!(textField)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return pinDelegate.textFieldShouldEndEditing!(textField)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if (shouldHideText && text != defaultChar){
            plainText = textField.text
            let charArray: Array<Character> = Array(repeating: "●", count: numOfDigits)
            text = String(charArray)
        }
         pinDelegate.textFieldDidEndEditing?(textField)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return pinDelegate.textFieldShouldReturn!(textField)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        pinDelegate.textFieldDidBeginEditing?(textField)
    }
    
    @objc func textChanged(_ notification: Notification){
        print("edited \(text ?? "")")
        if (text == ""){
            text = defaultChar
            if (previousTextField != nil){
                previousTextField!.becomeFirstResponder()
            }
        } else if (text?.count == numOfDigits) {
            if (nextTextField == nil){
                endEditing(false)
                pinDelegate.pinCompleted?()
            }
        }

    }
    
    public override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    public func unlockedByTouchId(){
        text = "●"
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
