//
//  TtroTextField.swift
//  PayWandDemo
//
//  Created by Farid on 7/28/16.
//  Copyright © 2016 Farid. All rights reserved.
//

import UIKit


public class TtroTextField: UITextField {
    
    fileprivate var _inputMode = InputMode.all
    public var inputMode : InputMode {
        get {
            return _inputMode
        }
        set {
            _inputMode = newValue
        }
    }
    
    var _style : Style = .dark
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame : frame)
    }
    
    public convenience init(placeholder : String, fontSize : CGFloat){
        self.init(placeholder : placeholder, font: UIFont.TtroFonts.regular(size: fontSize).font)
    }
    
    public convenience init(placeholder : String, font : UIFont){
        self.init(frame: CGRect.zero)
        self.font = font
        borderStyle = .roundedRect
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        //textAlignment = .Center
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textColor = UIColor.TtroColors.white.color
        attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.TtroColors.white.color.withAlphaComponent(0.5)])
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = UIColor.TtroColors.white.color
    }
    
    public enum Style {
        case light
        case dark
        case readOnly
        case wrongFormat
    }
    
    public enum InputMode {
        case all
        case phoneNumber
        case digit
        case double
        case alphaNumeric
        case name
        case email
    }
    
    public func setStyle(_ style : Style){
        switch style {
        case .dark:
            backgroundColor = UIColor.TtroColors.darkBlue.color.withAlphaComponent(0.4)
            borderStyle = .roundedRect
        case .light:
            backgroundColor = UIColor.white.withAlphaComponent(0.2)
            borderStyle = .roundedRect
        case .readOnly:
            backgroundColor = UIColor.clear
            borderStyle = .none
        case .wrongFormat:
            backgroundColor = UIColor.red.withAlphaComponent(0.4)
//            borderStyle = .roundedRect
//            layer.borderColor = UIColor.red.cgColor
//            layer.borderWidth = 1
        }
    }
    
    public func setStyle(_ editable : Bool, isProfileTable : Bool){
        if (editable){
            if (isProfileTable){
                _style = .dark
            } else {
                _style = .light
            }
        } else {
            _style = .readOnly
        }
        setStyle(_style)
    }
    
    public func checkInputCharacters(shouldChangeCharactersIn range: NSRange,
                    replacementString string: String) -> Bool {
        var inverseSet : CharacterSet!
        // Create an `NSCharacterSet` set which includes everything *but* the digits
        switch _inputMode {
        case .phoneNumber:
            inverseSet = CharacterSet(charactersIn:"0123456789").inverted
        case .digit:
            inverseSet = CharacterSet(charactersIn:"0123456789").inverted
        case .double:
            inverseSet = CharacterSet(charactersIn:"0123456789.").inverted
        case .name:
            inverseSet = CharacterSet.letters
            inverseSet.insert(" ")
            inverseSet = inverseSet.inverted
        case .alphaNumeric:
            inverseSet = CharacterSet.alphanumerics.inverted
        default:
            return true
        }
        
        // At every character in this "inverseSet" contained in the string,
        // split the string up into components which exclude the characters
        // in this inverse set
        let components = string.components(separatedBy: inverseSet)
        
        // Rejoin these components
        let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
        
        switch _inputMode {
        case .phoneNumber:
            if ((text!.characters.count) == 13 && string != "")
            {
                self.endEditing(true)
            }
        default:
            break
        }
        
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        return string == filtered
    }

}

// MARK : Validation
extension TtroTextField {
    
    public func checkValidity() -> Bool{
        var state : Bool = true
        switch inputMode {
        case .email:
            state = isValidEmail()
        case .name:
            state = isValidName()
        default:
            break
        }
        if (!state) {
            setStyle(.wrongFormat)
        } else {
            setStyle(_style)
        }
        return state
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text!)
    }
    
    func isValidName() -> Bool {
        let nameRegEx = "[A-Za-z]{1,30}"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self.text!)
    }
}


public class TtroTextView: UITextView, UITextViewDelegate {
    
    public var textFieldDelegate : UITextFieldDelegate!
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    public convenience init(placeholder : String, fontSize : CGFloat){
        self.init(frame: CGRect.zero)
        font = UIFont.TtroFonts.regular(size: fontSize).font
        //borderStyle = .RoundedRect
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.clear.cgColor
        //textAlignment = .Center
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textColor = UIColor.TtroColors.white.color
        tintColor = UIColor.TtroColors.white.color
        
        delegate = self
        
        //attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.TtroColors.White.color.colorWithAlphaComponent(0.5)])
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return textFieldDelegate.textFieldShouldBeginEditing!(UITextField())
    }
    
    public func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return textFieldDelegate.textFieldShouldEndEditing!(UITextField())
    }
    
    public func textViewDidBeginEditing(_ textView: UITextView) {
        textFieldDelegate.textFieldDidBeginEditing!(UITextField())
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        textFieldDelegate.textFieldDidEndEditing!(UITextField())
    }
}
