import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var highscore: UILabel!
    var score: String = "0"
    
    @IBAction func startPressed(_ sender: UIButton) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btnStart.transform = CGAffineTransform(rotationAngle: 25)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        btnStart.pulsate()
        highscore.text = self.score
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
