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
    public var style : Style {
        get {
            return _style
        }
        set {
            _style = newValue
            setStyle(_style)
        }
    }
    
    var corners : UIRectCorner! = []
    var radius : CGFloat! = 10
    
    var doubleString = ""
    let maxNumberDecimals = 2
    
    public var shouldMoveUpOnBeginEdit : Bool = true
    
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
//        borderStyle = .roundedRect
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 0
        //textAlignment = .Center
//        backgroundColor = UIColor.white.withAlphaComponent(0.2)
        style = .light
        textColor = UIColor.TtroColors.white.color
        attributedPlaceholder = NSAttributedString(string:placeholder, attributes:[NSForegroundColorAttributeName: UIColor.TtroColors.white.color.withAlphaComponent(0.5)])
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = UIColor.TtroColors.white.color
    }
    
    public enum Style {
        case light
        case dark
//        case readOnly
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
            layer.cornerRadius = 5
        case .light:
            backgroundColor = UIColor.white.withAlphaComponent(0.2)
            layer.cornerRadius = 5
        case .wrongFormat:
            backgroundColor = UIColor.red.withAlphaComponent(0.4)
        }
    }
    
    public func setStyle(isProfileTable : Bool){
        if (isProfileTable){
            style = .dark
        } else {
            style = .light
        }
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
            inverseSet = CharacterSet(charactersIn:"0123456789".appending(Locale.current.decimalSeparator ?? ".")).inverted
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
            
        case .double:
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale.current
            
            let newRange = getRangeInDoubeString(range: range, inverseSet: inverseSet)
            let editIndex = doubleString.index(doubleString.startIndex, offsetBy: newRange.location)
            
            if filtered != "" {
                if getDecimalPointDigitCount(amount: numberFormatter.number(from: doubleString)?.doubleValue ?? 0) == maxNumberDecimals { //reached maximum number of decimals
                    return false
                }
                var tmp = doubleString
                tmp.insert(contentsOf: filtered.characters, at: editIndex)
                if let amount = numberFormatter.number(from: tmp)?.doubleValue { //(from: doubleString.appending(filtered))?.doubleValue {
//                    doubleString.append(filtered)
                    doubleString = tmp
                    text = getTextAmount(amount: amount)
                }
                if filtered == Locale.current.decimalSeparator {
                    text?.append(filtered)
                }
            }
            else {
                if (text?.characters.count ?? 0) > 0{
                    if let char = text?.unicodeScalars.last,
                        CharacterSet.decimalDigits.contains(char) {
                        
                        let deleting = text!.substring(from: text!.index(text!.endIndex, offsetBy: -1))
                        if let range = doubleString.range(of: deleting, options: String.CompareOptions.backwards, range: nil, locale: nil) {
                            print(range)
                            doubleString.removeSubrange(range.lowerBound..<doubleString.endIndex)
                        }
                        if let amount = numberFormatter.number(from: doubleString)?.doubleValue {
                            text = getTextAmount(amount: amount)
                        } else {
                            text = ""
                        }
                    }
                }
            }
            return false
        default:
            break
        }
        
        
        // If the original string is equal to the filtered string, i.e. if no
        // inverse characters were present to be eliminated, the input is valid
        // and the statement returns true; else it returns false
        return string == filtered
    }
    
    public func setCurvature(corners : UIRectCorner, radius : CGFloat){
        self.corners = corners
        self.radius = radius
        borderStyle = .none
        layer.cornerRadius = 0
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        if (!corners.isEmpty){
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            self.layer.mask = mask
            borderStyle = .none
            layer.cornerRadius = 0
        }
    }
    
    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    func getDecimalPointDigitCount(amount: Double) -> Int {
        for i in 0..<maxNumberDecimals {
            let tmp = amount * pow(10.0, Double(i))
            if trunc(tmp) == tmp {
                return i
            }
        }
        return maxNumberDecimals
    }
    
    func getTextAmount(amount: Double) -> String{
        return String.localizedStringWithFormat("%.\(getDecimalPointDigitCount(amount: amount))f", amount)
    }
    
    func getRangeInDoubeString(range: NSRange, inverseSet: CharacterSet) -> NSRange {
        if let startIndex = text?.startIndex,
            let endIndex = text?.index(startIndex, offsetBy: range.location),
            let subText = text?.substring(with: startIndex..<endIndex){
            let components = subText.components(separatedBy: inverseSet)
            var newRange = range
            newRange.location = range.location - components.count + 1
            return newRange
        }
        return range
    }
}

// MARK : Validation
extension TtroTextField {
    
    @discardableResult public func checkValidity() -> Bool{
        var state : Bool = true
        switch inputMode {
        case .email:
            state = isValidEmail()
        case .name:
            state = isValidName()
        case .phoneNumber:
            state = isValidPhone()
        default:
            break
        }
        if (!state) {
            setStyle(.wrongFormat)
        } else {
            setStyle(style)
        }
        return state
    }
    
    public func setToNormalState(){
        setStyle(style)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text!)
    }
    
    func isValidName() -> Bool {
        let nameRegEx = "[A-Za-z ]{2,30}"
        
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self.text!)
    }
    
    func isValidPhone() -> Bool {
        let phoneRegEx = "[0-9]{8,12}"
        
        let phoneTest = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneTest.evaluate(with: self.text!)
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
        self.init(placeholder : placeholder, font: UIFont.TtroFonts.regular(size: fontSize).font)
    }
    
    public convenience init(placeholder : String, font : UIFont){
        self.init(frame: CGRect.zero)
        self.font = font
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
