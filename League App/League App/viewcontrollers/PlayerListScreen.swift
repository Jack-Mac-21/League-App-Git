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
    @IBOutlet weak var SkillInput: UITextField!
    @IBOutlet weak var AgeInput: UITextField!
    @IBOutlet weak var TableView: UITableView!
    
    var _Players: [Player] = []
    var _PlayerNameList: [String] = []
    var _League: League! //Forcing this to be a league, could lead to a crash
    var _Delegate: DataDelegate?
    
    //Runs right before the viewcontroller appears
    //Passes in the given league date to display at the top
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let givenLeague = _League{
            LeagueName.text = givenLeague.Title
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        self._Players = self._League.PlayerList

    }
    
    //Updates the player in the dictionary with the new player
    //from the ScoreScreen, used to save a players score
    func updatePlayer(player: Player){
        _League.PlayersDict[player.Name] = player
    }
    
    //When the user presses add player
    @IBAction func AddPlayer(_ sender: Any) {
        let _player = Player(givenName: NameInput.text ?? "no_name", givenAge: Int(AgeInput.text ?? "0") ?? 0, givenSkill: Double(SkillInput.text ?? "0.0") ?? 0.0) //Takes input fields to create a new player and adds to the array
        if self._PlayerNameList.contains(_player.Name) == false{
            self._PlayerNameList.append(_player.Name)
            self._Players.append(_player)
            self._League?.PlayerList.append(_player)
            self._League?.PlayersDict[_player.Name] = _player
            
            _Delegate?.updateLeague(league: self._League, player: _player)
            
            TableView.beginUpdates()
            TableView.insertRows(at: [IndexPath(row: self._Players.count - 1, section: 0)], with: .automatic) /// animate the insertion
            TableView.endUpdates()
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeagueToPlayer"{
            let destVC = segue.destination as! PlayerScoreScreen
            
            let playerIndex = TableView.indexPathForSelectedRow!
            destVC.givenName = self._PlayerNameList[playerIndex.row]
            destVC.currPlayer = self._League.PlayersDict[self._PlayerNameList[playerIndex.row]] //gets the current player
            destVC.dataDelegate = self
        }
    }
}

extension PlayerListScreen: UITableViewDataSource, UITableViewDelegate{ //Deciding the amount of rows
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self._Players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = self._Players[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
        
        cell.setPlayer(player: player) //Specifiying the parameters in the cell
        
        return cell
    }
}
