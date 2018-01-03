import UIKit

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var player: Player! {
        didSet {
            highscore.text = String(player.highscore)
            nameLabel.text = player.name
        }
    }
}

