import UIKit

extension UIColor {
    convenience init(rgba: String) {
        var red: CGFloat   = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat  = 0.0
        var alpha: CGFloat = 1.0
        
        if rgba.hasPrefix("#") {
            let hex = rgba.substringFromIndex(rgba.startIndex.advancedBy(1))
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                if (hex as NSString).length == 6 {
                    red   = CGFloat(UInt32(hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat(UInt32(hexValue & 0x00FF00) >> 8)  / 255.0
                    blue  = CGFloat(UInt32(hexValue) & 0x0000FF) / 255.0
                } else if (hex as NSString).length == 8 {
                    red   = CGFloat(UInt32(hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat(UInt32(hexValue & 0x00FF0000) >> 16) / 255.0
                    blue  = CGFloat(UInt32(hexValue & 0x0000FF00) >> 8)  / 255.0
                    alpha = CGFloat(UInt32(hexValue) & 0x000000FF) / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9")
                }
            } else {
                print("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func rgbaHexString() -> String {
        var red:CGFloat = 0.0
        var green:CGFloat = 0.0
        var blue:CGFloat = 0.0
        var alpha:CGFloat = 0.0
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return String(format:"#%02X%02X%02X%02X", Int(red  * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
    }
}