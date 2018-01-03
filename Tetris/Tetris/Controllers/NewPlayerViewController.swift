import RealmSwift
import UIKit

class NewPlayerViewController: UIViewController {
    @IBOutlet weak var txtPlayername: UITextField!
    var player: Player?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Create new player
        player = Player(name: txtPlayername.text!)
    }
}
