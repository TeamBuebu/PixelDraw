import UIKit

class MainViewController: UIViewController {
    var pixelGrid: PixelGridView!
    let gridColor = UIColor(rgba: "#efefefff")
    let gridSize = 11
    var selectedColor = UIColor.clearColor()
    let colors = [UIColor(rgba: "#1364b7FF"), UIColor(rgba: "#13b717FF"), UIColor(rgba: "#ffea00FF"), UIColor(rgba: "#000000FF"), UIColor.clearColor()]
    
    @IBOutlet weak var touchView: TouchTrackerView!
    @IBOutlet weak var color1ControlView: ColorControlView!
    @IBOutlet weak var color2ControlView: ColorControlView!
    @IBOutlet weak var color3ControlView: ColorControlView!
    @IBOutlet weak var color4ControlView: ColorControlView!
    @IBOutlet weak var color5ControlView: ColorControlView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initColorControls()
        
        pixelGrid = PixelGridView(gridSize: gridSize, gridColor: gridColor)
        pixelGrid.translatesAutoresizingMaskIntoConstraints = false
        self.view.insertSubview(pixelGrid, belowSubview: touchView)
        let c1 = NSLayoutConstraint(item: pixelGrid, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: touchView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: pixelGrid, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: touchView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let c3 = NSLayoutConstraint(item: pixelGrid, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: touchView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let c4 = NSLayoutConstraint(item: pixelGrid, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: touchView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        self.view.addConstraints([c1, c2, c3, c4])
        
        touchView.onPathDrawn = { points in
            self.pixelGrid.colorizeSquaresOnPath(points, color: self.selectedColor)
        }
    }
    
    func initColorControls() {
        let controls = [color1ControlView, color2ControlView, color3ControlView, color4ControlView, color5ControlView]
        
        for (index,control) in controls.enumerate() {
            control.backgroundColor = colors[index]
            control.onSelect = {
                for controlToBeDisabled in controls {
                    controlToBeDisabled.isControlSelected = false
                }
                control.isControlSelected = true
                self.selectedColor = control.backgroundColor!
            }
        }
        
        color1ControlView.isControlSelected = true
        self.selectedColor = color1ControlView.backgroundColor!
    }
    
    @IBAction func clearGrid(sender: AnyObject) {
        let alertController = UIAlertController(title: "Alle Pixel löschen?", message: "Möchtest du wirklich alle Pixel löschen. Dies kann nicht rückgangig gemacht werden.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in}
        alertController.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .Default) { (action) in
            self.pixelGrid.clearSquares()
        }
        alertController.addAction(deleteAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func logResult(sender: AnyObject) {
        // TODO: log the result in the logbook in the required format
        var json = [String : AnyObject]()
        json["task"] = "Pixelmaler"
        let solutionLogger = SolutionLogger(viewController: self)
        json["pixels"] = pixelGrid.getSquaresAsJsonArray()
        let solutionStr = solutionLogger.JSONStringify(json)
        solutionLogger.logSolution(solutionStr)
    }
}
