//
//  TtroTextField.swift
//  PayWandDemo
//
//  Created by Farid on 7/28/16.
//  Copyright © 2016 Farid. All rights reserved.
//

import UIKit


class TtroTextField: UITextField {
    
    fileprivate var _inputMode = InputMode.all
    var inputMode : InputMode {
        get {
            return _inputMode
        }
        set {
            _inputMode = newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame : frame)
    }
    
    convenience init(placeholder : String, fontSize : CGFloat){
        self.init(placeholder : placeholder, font: UIFont.ttroFonts.regular(size: fontSize).font)
    }
    
    convenience init(placeholder : String, font : UIFont){
        self.init(frame: CGRect.zero)
        self.font = font
        borderStyle = .roundedRect
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        //textAlignment = .Center
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textColor = UIColor.ttroColors.white.color
        attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.ttroColors.white.color.withAlphaComponent(0.5)])
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = UIColor.ttroColors.white.color
        delegate = self
    }
    
    enum Style {
        case light
        case dark
        case readOnly
    }
    
    enum InputMode {
        case all
        case phoneNumber
        case digit
        case double
        case alphaNumeric
        case name
    }
    
    func setStyle(_ style : Style){
        switch style {
        case .dark:
            backgroundColor = UIColor.ttroColors.darkBlue.color.withAlphaComponent(0.4)
            borderStyle = .roundedRect
        case .light:
            backgroundColor = UIColor.white.withAlphaComponent(0.2)
            borderStyle = .roundedRect
        case .readOnly:
            backgroundColor = UIColor.clear
            borderStyle = .none
        }
    }
    
    func setStyle(_ editable : Bool, isProfileTable : Bool){
        if (editable){
            if (isProfileTable){
                setStyle(.dark)
            } else {
                setStyle(.light)
            }
        } else {
            setStyle(.readOnly)
        }
    }
    
    func checkInputCharacters(shouldChangeCharactersIn range: NSRange,
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

extension TtroTextField : UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        return checkInputCharacters(shouldChangeCharactersIn: range, replacementString: string)
    }
}


class TtroTextView: UITextView, UITextViewDelegate {
    
    var textFieldDelegate : UITextFieldDelegate!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
    }
    
    convenience init(placeholder : String, fontSize : CGFloat){
        self.init(frame: CGRect.zero)
        font = UIFont.ttroFonts.regular(size: fontSize).font
        //borderStyle = .RoundedRect
        layer.cornerRadius = 5
        layer.masksToBounds = true
        layer.borderColor = UIColor.clear.cgColor
        //textAlignment = .Center
        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        textColor = UIColor.ttroColors.white.color
        tintColor = UIColor.ttroColors.white.color
        
        delegate = self
        
        //attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.ttroColors.White.color.colorWithAlphaComponent(0.5)])
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return textFieldDelegate.textFieldShouldBeginEditing!(UITextField())
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return textFieldDelegate.textFieldShouldEndEditing!(UITextField())
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textFieldDelegate.textFieldDidBeginEditing!(UITextField())
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textFieldDelegate.textFieldDidEndEditing!(UITextField())
    }
}
