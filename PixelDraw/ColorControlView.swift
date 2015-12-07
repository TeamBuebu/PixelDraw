import Foundation
import UIKit

class ColorControlView : UIView {
    var onSelect: ()->() = {}
    
    var isControlSelected:Bool = false {
        didSet {
            if isControlSelected {
                self.layer.borderWidth = 4
                self.layer.borderColor = UIColor.orangeColor().CGColor
            } else {
                self.layer.borderWidth = 1
                self.layer.borderColor = UIColor.darkGrayColor().CGColor
            }
        }
    }
    
    override func awakeFromNib() {
        self.isControlSelected = false
        let tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("viewTapped:"))
        self.addGestureRecognizer(tapRecognizer)
    }
    
    func viewTapped(sender:UITapGestureRecognizer) {
        onSelect()
    }
}