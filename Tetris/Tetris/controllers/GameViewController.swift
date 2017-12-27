import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var score: Int = 0
    
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
    
    func handleFullLine(_ row: Int, _ score: Int) {
        let position : CGPoint = scene.pointFor(column:13,row:20)
        scene.animatePointsLine(row,score,position)
        {
            self.score = self.score + score
            self.lblScore.text = String(self.score)
        }
    }
    
    func handleBufferBlock(_ type: String){
        self.imgBufferBlock.image = UIImage.init(named: type)
    }
}
