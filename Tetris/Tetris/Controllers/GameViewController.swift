import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var scene: GameScene!
    var highscore: Int = 0
    
    @IBOutlet weak var txtLevel: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgBufferBlock: UIImageView!
    @IBOutlet weak var txtLinesCleared: UILabel!
    
    @IBAction func exitGame(_ sender: UIButton) {
        self.scene.removeAllActions()
        self.scene.removeAllChildren()
        self.scene.removeFromParent()
        self.scene = nil
        handleGameOver()
    }
    
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
    
    func handleFullLine(_ row: Int, _ score: Int, _ linesCleared: Int, _ level: Int) {
        let position : CGPoint = scene.pointFor(column:13,row:20)
        scene.animatePointsLine(row,score,position)
        {
            self.highscore = self.highscore + score
            self.lblScore.text = String(self.highscore)
            self.txtLinesCleared.text = String(linesCleared)
            self.txtLevel.text = String(level)
        }
    }
    
    func handleBufferBlock(_ type: String){
        self.imgBufferBlock.image = UIImage.init(named: type)
    }
    
    func handleGameOver() {
        
    }
}
