import RealmSwift
import UIKit

class Player: Object {
    @objc dynamic var playerID = UUID().uuidString
    @objc dynamic var highscore = Int()
    @objc dynamic var name = "player"
    
    override static func primaryKey() -> String? {
        return "playerID"
    }
    
    convenience init(name: String){
        self.init()
        self.name = name
        self.highscore = 0
    }
}
