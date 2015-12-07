import Foundation
import UIKit

struct LineIntersection {
    static private func lineIntersectsLine(line1Start:CGPoint, line1End: CGPoint, line2Start: CGPoint, line2End:CGPoint) -> Bool
    {
        var q:CGFloat =
        //Distance between the lines' starting rows times line2's horizontal length
        (line1Start.y - line2Start.y) * (line2End.x - line2Start.x)
            //Distance between the lines' starting columns times line2's vertical length
            - (line1Start.x - line2Start.x) * (line2End.y - line2Start.y);
        let d:CGFloat =
        //Line 1's horizontal length times line 2's vertical length
        (line1End.x - line1Start.x) * (line2End.y - line2Start.y)
            //Line 1's vertical length times line 2's horizontal length
            - (line1End.y - line1Start.y) * (line2End.x - line2Start.x);
        
        if d == 0 {
            return false
        }
        
        let r:CGFloat = q / d;
        
        q =
            //Distance between the lines' starting rows times line 1's horizontal length
            (line1Start.y - line2Start.y) * (line1End.x - line1Start.x)
            //Distance between the lines' starting columns times line 1's vertical length
            - (line1Start.x - line2Start.x) * (line1End.y - line1Start.y);
        
        let s:CGFloat = q / d;
        if( r < 0 || r > 1 || s < 0 || s > 1 ){
            return false
        }
        
        return true
    }
    
    /*Test whether the line intersects any of:
    *- the bottom edge of the rectangle
    *- the right edge of the rectangle
    *- the top edge of the rectangle
    *- the left edge of the rectangle
    *- the interior of the rectangle (both points inside)
    */
    static func rectContainsLine(r:CGRect,lineStart:CGPoint , lineEnd:CGPoint) -> Bool
    {
        return (lineIntersectsLine(lineStart, line1End: lineEnd, line2Start: CGPointMake(r.origin.x, r.origin.y), line2End: CGPointMake(r.origin.x + r.size.width, r.origin.y)) ||
            lineIntersectsLine(lineStart, line1End: lineEnd, line2Start: CGPointMake(r.origin.x + r.size.width, r.origin.y), line2End: CGPointMake(r.origin.x + r.size.width, r.origin.y + r.size.height)) ||
            lineIntersectsLine(lineStart, line1End: lineEnd, line2Start: CGPointMake(r.origin.x + r.size.width, r.origin.y + r.size.height), line2End: CGPointMake(r.origin.x, r.origin.y + r.size.height)) ||
            lineIntersectsLine(lineStart, line1End: lineEnd, line2Start: CGPointMake(r.origin.x, r.origin.y + r.size.height), line2End: CGPointMake(r.origin.x, r.origin.y)) ||
            (CGRectContainsPoint(r, lineStart) && CGRectContainsPoint(r, lineEnd)));
    }
}