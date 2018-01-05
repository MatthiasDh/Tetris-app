import RealmSwift
import UIKit

class PlayersViewController: UIViewController {
    private var indexPathPlayer: IndexPath!
    var players: Results<Player>!
 
    @IBOutlet weak var btnAddPlayer: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidAppear(_ animated: Bool) {
        btnAddPlayer.pulsate()
    }
    
    override func viewDidLoad() {
        players = try! Realm().objects(Player.self)
        //Tableview design
        tableView.separatorStyle = .none
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    @IBAction func didUnwindFromNewPlayerVC(_ sender: UIStoryboardSegue){
        guard let newPlayerVC = sender.source as? NewPlayerViewController else { return }
        let realm = try! Realm()
        try! realm.write {
            realm.add(newPlayerVC.player!)
        }
        tableView.insertRows(at: [IndexPath(row: players.count - 1, section: 0)], with: .automatic)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "startscreenSegue") {
            guard let startVC = segue.destination as? StartViewController else { return }
            startVC.player = players[indexPathPlayer.row]
        }
    }
}

extension PlayersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPathPlayer = indexPath
        self.performSegue(withIdentifier: "startscreenSegue", sender: self)
    }
}

extension PlayersViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        cell.player = players[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let modifyAction = UIContextualAction(style: .normal, title:  "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let realm = try! Realm()
            try! realm.write {
                realm.delete(self.players[indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        })
        modifyAction.title = "Delete"
        modifyAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [modifyAction])
    }
}
