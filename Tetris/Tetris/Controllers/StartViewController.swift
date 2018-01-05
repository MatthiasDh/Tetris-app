import RealmSwift
import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var highscore: UILabel!
    var score: Int = 0
    var player: Player!

    @IBOutlet weak var playername: UILabel!
    @IBAction func startPressed(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player = player {
            btnStart.pulsate()
            btnStart.transform = CGAffineTransform(rotationAngle: 25)
            highscore.text = String(player.highscore)
            playername.text = "Welcome " + player.name + "!"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        btnStart.pulsate()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didUnwindFromGameVC(_ sender: UIStoryboardSegue){
        self.score = Int(self.highscore.text!)!
        guard var gameVC = sender.source as? GameViewController else { return }
        //If it is a highscore then change the score on the startscreen
        if(gameVC.highscore > self.score){
            self.highscore.text = gameVC.lblScore.text
            
                //Update the player in the localstorage
                let realm = try! Realm()
                try! realm.write {
                    player.highscore = gameVC.highscore
                    realm.add(player, update: true)
                }
        }
        gameVC = GameViewController()
    }
}
