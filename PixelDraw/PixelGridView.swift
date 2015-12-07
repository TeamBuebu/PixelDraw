import UIKit

class PixelGridView: UIView {
    let gridSize: Int
    let gridColor: UIColor
    var squareSize: Int = 0
    var squares = [UIView]()

    init(gridSize: Int, gridColor: UIColor) {
        self.gridSize = gridSize
        self.gridColor = gridColor
        super.init(frame:CGRectZero)
        renderGrid()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func renderGrid() {
        let screenSize = UIScreen.mainScreen().bounds.size
        let smallerSide = min(screenSize.width, screenSize.height)
        self.squareSize = Int(smallerSide) / gridSize
        
        // TODO: set up square-views and position them one after another to form a grid
        for var y = 0; y < gridSize; y++ {
            for var x = 0; x < gridSize; x++ {
                let square = UIView(frame: CGRect(x:x * squareSize, y:y * squareSize, width:squareSize, height:squareSize))
                square.layer.borderWidth = 1.0
                square.layer.borderColor = gridColor.CGColor
                
                self.addSubview(square)
            }
        }
    }
    
    func colorizeSquaresOnPath(path: [CGPoint], color: UIColor) {
        var previousPoint:CGPoint?
        for currentPoint in path {
            if let lineStart = previousPoint {
                colorizeSquares(color) { square in
                    // TODO: return whether the square's frame has been intersected by the drawn path segment. Use the LineIntersection class.
                    return LineIntersection.rectContainsLine(square.frame, lineStart: lineStart, lineEnd: currentPoint)
                }
            } else {
                /* For the first point we only check if the point is contained in a view's coordinates rect */
                colorizeSquares(color) { square in
                    return CGRectContainsPoint(square.frame, currentPoint)
                }
            }
            previousPoint = currentPoint
        }
    }
    
    private func colorizeSquares(color: UIColor, condition:(UIView) -> (Bool) ){
        // TODO: set the background color for all squares for which condition(square) == true
        for var square in self.subviews {
            if (condition(square)) {
                
                square.layer.backgroundColor = color.CGColor
                
                if let index = squares.indexOf(square) {
                    squares.removeAtIndex(index)
                }
                    
                if (color != UIColor.clearColor()) {
                    squares.append(square)
                }
            }
        }
    }

    func clearSquares() {
        // TODO: clear the background color of all squares
        for var square in self.subviews {
            square.layer.backgroundColor = UIColor.clearColor().CGColor
        }
        self.squares.removeAll()
    }
    
    func getSquaresAsJsonArray() -> NSArray {
        
        var jsonArray = [[String : AnyObject]]()
        
        for var square in squares {
            let jsonSquare: [String:AnyObject] = [
                "x": Int((square.frame as CGRect).minX) / squareSize,
                "y": Int((square.frame as CGRect).minY) / squareSize,
                "color": (square.backgroundColor?.rgbaHexString())!]
            jsonArray.append(jsonSquare)
        }
        
        return jsonArray
    }
}

