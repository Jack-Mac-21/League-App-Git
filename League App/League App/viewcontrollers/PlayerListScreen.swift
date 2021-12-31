//
//  PlayerListScreen.swift
//  League App
//
//  Created by JackMac on 12/19/21.
// The view controller for the TableView odf players

import UIKit


protocol DataDelegatePlayerListScreen{
    func updatePlayer(player: Player) //Updates the score info for the given player 
}

class PlayerListScreen: UIViewController, DataDelegatePlayerListScreen {
    
    @IBOutlet weak var LeagueName: UILabel!
    @IBOutlet weak var NameInput: UITextField!
    @IBOutlet weak var TableView: UITableView!
    
    var _League: League! //Forcing this to be a league, could lead to a crash
    var _DelegateForLeague: DataDelegate?
    var addedPlayer: Player = Player(givenName: "NULL987654321")
    
    //Runs right before the viewcontroller appears
    //Passes in the given league date to display at the top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let givenLeague = _League{
            LeagueName.text = givenLeague.Title
        }
        TableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self

    }
    
    //Updates the player in the dictionary with the new player
    //from the ScoreScreen, used to save a players score
    func updatePlayer(player: Player){
        _League.PlayersDict[player.Name] = player
        TableView.reloadData()
    }
    
    //When the user presses add player
    @IBAction func AddPlayer(_ sender: Any) {
        let _player = Player(givenName: NameInput.text ?? "no_name") //Takes input fields to create a new player and adds to the array
        if self._League.PlayersDict[_player.Name] == nil{
            _DelegateForLeague?.updateLeague(league: self._League, player: _player)
            
            self.addedPlayer = _player
            TableView.beginUpdates()
            TableView.insertRows(at: [IndexPath(row: self._League.PlayersDict.count - 1, section: 0)], with: .automatic) /// animate the insertion
            TableView.endUpdates()
            NameInput.text = ""
            
            self._League?.PlayersDict[_player.Name] = _player
            
            self.addedPlayer = Player(givenName: "NULL987654321")
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeagueToPlayer"{
            let destVC = segue.destination as! PlayerScoreScreen
            
            let playerIndex = TableView.indexPathForSelectedRow!
            let selectedCell = TableView.cellForRow(at: playerIndex) as! PlayerCell
            destVC.givenName = selectedCell.Name.text
            destVC.currPlayer = _League.PlayersDict[selectedCell.Name.text ?? "Error: Not found"]//gets the current player
            destVC.dataDelegate = self
            
            //Initializing total to prevent a crash
            var totalPar = 0
            var totalScore = 0
            
            for num in destVC.currPlayer.ParNums{
                totalPar += num
            }
            for num in destVC.currPlayer.Scores{
                totalScore += num
            }
            destVC.totalScore = totalScore
            destVC.totalPar = totalPar
            destVC.givenLeague = _League
            
        }
    }
}

extension PlayerListScreen: UITableViewDataSource, UITableViewDelegate{ //Deciding the amount of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._League.PlayersDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let players = Array(self._League.PlayersDict.keys)
        
        let playerName = players[indexPath.row]
        
        if self.addedPlayer.Name == "NULL987654321"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
            
            cell.setPlayer(player: _League.PlayersDict[playerName]!) //Specifiying the parameters in the cell
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
            
            cell.setPlayer(player: self.addedPlayer) //Specifiying the parameters in the cell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            
            let cell = tableView.cellForRow(at: indexPath) as! PlayerCell
            
            let playerName = cell.Name.text
            
            _League.PlayersDict.removeValue(forKey: playerName!)

            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
}
