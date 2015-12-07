import UIKit

class TouchTrackerView: UIView {
    let touchPath: UIBezierPath = {
        let path = UIBezierPath()
        path.lineWidth = 4.0
        return path
    }()
    var points = [CGPoint]()
    var onPathDrawn: ([CGPoint]) -> () = { (points) in }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.locationInView(self)
            points.append(touchPoint)
            touchPath.moveToPoint(touchPoint)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let touchPoint = touch.locationInView(self)
            points.append(touchPoint)
            touchPath.addLineToPoint(touchPoint)
            setNeedsDisplay()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        onPathDrawn(self.points)
        points = []
        touchPath.removeAllPoints()
        setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        if let touches = touches {
            touchesEnded(touches, withEvent: event)
        }
    }
    
    override func drawRect(rect: CGRect) {
        touchPath.stroke()
    }
}
