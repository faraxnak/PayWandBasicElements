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

class TtroDigitEntry: UITextField, UITextFieldDelegate {
    
    
    var nextTextField : TtroDigitEntry?
    var previousTextField : TtroDigitEntry?
    
    var pinDelegate : TtroDigitEntryDelegate!
    
    var numOfDigits = 1
    
    var defaultChar = "_"
    
    enum Mode {
        case light
        case dark
    }
    
    convenience init(next : TtroDigitEntry?, previous : TtroDigitEntry?, defaultChar : String = "_", mode : Mode = .light){
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
            textColor = UIColor.ttroColors.white.color
            self.backgroundColor = UIColor.ttroColors.white.color.withAlphaComponent(0.2)
        case .dark:
            textColor = UIColor.ttroColors.darkBlue.color
            self.backgroundColor = UIColor.ttroColors.darkBlue.color.withAlphaComponent(0.2)
        }
        
        font = UIFont.ttroFonts.regular(size: 20).font
        text = defaultChar
        self.defaultChar = defaultChar
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        let inverseSet = CharacterSet(charactersIn:"0123456789●" + defaultChar).inverted
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let components = string.components(separatedBy: inverseSet)
        
        // Rejoin these components
        let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        if (string != filtered){
            return false
        }
        
        if (string != ""){
            if (text == defaultChar){
                text = ""
            } else if text?.characters.count == numOfDigits {
                if (nextTextField != nil){
                    nextTextField?.text = ""
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
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (previousTextField?.text == defaultChar){
            previousTextField?.becomeFirstResponder()
            return false
        }
        return pinDelegate.textFieldShouldBeginEditing!(textField)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return pinDelegate.textFieldShouldEndEditing!(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
         pinDelegate.textFieldDidEndEditing?(textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return pinDelegate.textFieldShouldReturn!(textField)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pinDelegate.textFieldDidBeginEditing?(textField)
    }
    
    func textChanged(_ notification: Notification){
        print("edited \(text)")
        if (text == ""){
            text = defaultChar
            if (previousTextField != nil){
                previousTextField!.becomeFirstResponder()
            }
        } else if (text?.characters.count == numOfDigits) {
            if (nextTextField == nil){
                endEditing(false)
                pinDelegate.pinCompleted?()
            }
        }

    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    func unlockedByTouchId(){
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
