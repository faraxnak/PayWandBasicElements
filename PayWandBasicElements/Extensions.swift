//
//  Extensions.swift
//  PayWandBasicElements
//
//  Created by Farid on 12/15/16.
//  Copyright © 2016 ParsPay. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

protocol ttroColorProtocol {
    var color : UIColor { get }
}

extension UIColor {
    enum ttroColors : ttroColorProtocol {
        case white
        case darkBlue
        case lightBlue
        case cyan
        case green
        case orange
        case red
        
        var color: UIColor {
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

protocol ttroFontProtocol {
    var font : UIFont { get }
}

extension UIFont {
    enum ttroFonts : ttroFontProtocol {
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
        
        var font: UIFont {
            return getFont()
        }
    }
    
    enum ttroPayWandFonts : ttroFontProtocol {
        case semibold1, semibold2
        case regular1, regular2, regular3, regular4, regular5
        case light1, light2, light3, light4, light5
        
        fileprivate func getFont() -> UIFont {
            if (DeviceType.IS_IPAD){
                switch self {
                case .semibold1:
                    return ttroFonts.semibold(size: 20).font
                case .semibold2:
                    return ttroFonts.semibold(size: 40).font
                case .regular1:
                    return ttroFonts.regular(size: 24).font
                case .regular2:
                    return ttroFonts.regular(size: 30).font
                case .regular3:
                    return ttroFonts.regular(size: 36).font
                case .regular4:
                    return ttroFonts.regular(size: 40).font
                case .regular5:
                    return ttroFonts.regular(size: 48).font
                case .light1:
                    return ttroFonts.light(size: 16).font
                case .light2:
                    return ttroFonts.light(size: 20).font
                case .light3:
                    return ttroFonts.light(size: 24).font
                case .light4:
                    return ttroFonts.light(size: 30).font
                case .light5:
                    return ttroFonts.light(size: 36).font
                }
            }
            else if (DeviceType.IS_IPHONE_6 || DeviceType.IS_IPHONE_6P) {
                switch self {
                case .semibold1:
                    return ttroFonts.semibold(size: 18).font
                case .semibold2:
                    return ttroFonts.semibold(size: 40).font
                case .regular1:
                    return ttroFonts.regular(size: 20).font
                case .regular2:
                    return ttroFonts.regular(size: 24).font
                case .regular3:
                    return ttroFonts.regular(size: 30).font
                case .regular4:
                    return ttroFonts.regular(size: 36).font
                case .regular5:
                    return ttroFonts.regular(size: 44).font
                case .light1:
                    return ttroFonts.light(size: 14).font
                case .light2:
                    return ttroFonts.light(size: 20).font
                case .light3:
                    return ttroFonts.light(size: 24).font
                case .light4:
                    return ttroFonts.light(size: 28).font
                case .light5:
                    return ttroFonts.light(size: 34).font
                }
            }
            else {
                switch self {
                case .semibold1:
                    return ttroFonts.semibold(size: 14).font
                case .semibold2:
                    return ttroFonts.semibold(size: 40).font
                case .regular1:
                    return ttroFonts.regular(size: 16).font
                case .regular2:
                    return ttroFonts.regular(size: 20).font
                case .regular3:
                    return ttroFonts.regular(size: 24).font
                case .regular4:
                    return ttroFonts.regular(size: 30).font
                case .regular5:
                    return ttroFonts.regular(size: 40).font
                case .light1:
                    return ttroFonts.light(size: 12).font
                case .light2:
                    return ttroFonts.light(size: 16).font
                case .light3:
                    return ttroFonts.light(size: 20).font
                case .light4:
                    return ttroFonts.light(size: 24).font
                case .light5:
                    return ttroFonts.light(size: 30).font
                }
            }
        }
        
        var font: UIFont {
            return getFont()
        }
    }
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad || ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}
