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
    
    var _Players: [Player] = []
    var _PlayerNameList: [String] = []
    var _League: League! //Forcing this to be a league, could lead to a crash
    var _DelegateForLeague: DataDelegate?
    
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
        self._Players = self._League.PlayerList
        for player in _Players { //To reinstate the name list for indexing
            self._PlayerNameList.append(player.Name)
        }

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
        if self._PlayerNameList.contains(_player.Name) == false{
            self._PlayerNameList.append(_player.Name)
            self._Players.append(_player)
            self._League?.PlayerList.append(_player)
            self._League?.PlayersDict[_player.Name] = _player
            
            _DelegateForLeague?.updateLeague(league: self._League, player: _player)
            
            TableView.beginUpdates()
            TableView.insertRows(at: [IndexPath(row: self._Players.count - 1, section: 0)], with: .automatic) /// animate the insertion
            TableView.endUpdates()
            NameInput.text = ""
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeagueToPlayer"{
            let destVC = segue.destination as! PlayerScoreScreen
            
            let playerIndex = TableView.indexPathForSelectedRow!
            destVC.givenName = self._PlayerNameList[playerIndex.row]
            destVC.currPlayer = self._League.PlayersDict[self._PlayerNameList[playerIndex.row]] //gets the current player
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        
        cell.setPlayer(player: _League.PlayersDict[playerName]!) //Specifiying the parameters in the cell
        
        return cell
    }
}
