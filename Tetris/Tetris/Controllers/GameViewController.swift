import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var highscore: Int = 0
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgBufferBlock: UIImageView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure the view that displays spritecontent.
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the gamescene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        
        scene.addTiles()
        scene.FullLineHandler = handleFullLine
        scene.BufferBlockHandler = handleBufferBlock
        scene.generateBlock()
        // Present the scene.
        skView.presentScene(scene)
    }

    override func viewDidAppear(_ animated: Bool) {
    }
    
    func handleFullLine(_ row: Int, _ score: Int) {
        let position : CGPoint = scene.pointFor(column:13,row:20)
        scene.animatePointsLine(row,score,position)
        {
            self.highscore = self.highscore + score
            self.lblScore.text = String(self.highscore)
        }
    }
    
    func handleBufferBlock(_ type: String){
        self.imgBufferBlock.image = UIImage.init(named: type)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //If we can't cast the destination as a gameviewcontroller then quit
        guard let startVC = segue.destination as? StartViewController else { return }
        //Check if it is a highscore
        if(self.highscore > Int(startVC.score)!){
            startVC.score = lblScore.text!
        }
    }
}
