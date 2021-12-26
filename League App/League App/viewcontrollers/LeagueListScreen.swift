//
//  ViewController.swift
//  League App
//
//  Created by JackMac on 12/18/21.
//

import UIKit

protocol DataDelegate{
    func updateLeague(league: League, player: Player)
}

class LeagueListScreen: UIViewController, DataDelegate {
    @IBOutlet weak var AddLeagueButton: UIButton!
    @IBOutlet weak var LeagueNameInput: UITextField!
    @IBOutlet weak var LeagueTableView: UITableView!
    
    var leagues: [League] = []
    var LeagueDict = [String: League]()
    
    //Protocol Implementation to pass data back to this screen
    func updateLeague(league: League, player: Player){
        AddPlayerToLeague(givenLeague: league, givenPlayer: player)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LeagueTableView.reloadData()
    }
    
    @IBAction func AddLeague(_ sender: Any) {
        let tempLeague = League(givenTitle: LeagueNameInput.text ?? "error")
        leagues.append(tempLeague)
        LeagueDict[tempLeague.Title] = tempLeague
        
        LeagueTableView.beginUpdates()
        LeagueTableView.insertRows(at: [IndexPath(row: self.leagues.count - 1, section: 0)], with: .automatic) /// animate the insertion
        LeagueTableView.endUpdates()
        
        LeagueNameInput.text = ""
    }
    
    //Function testing if we are adding player from the player list screen
    //Need to update to update the correspounding league with the new player
    func AddPlayerToLeague(givenLeague: League, givenPlayer: Player){
        LeagueDict[givenLeague.Title]?.PlayersDict[givenPlayer.Name] = givenPlayer //Adds a given player to the given league
        
        
    }
    
    //preparing for the segue to the player list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaguesToLeague"{
            let indexPath = LeagueTableView.indexPathForSelectedRow!
            let destVC = segue.destination as! PlayerListScreen
            
            destVC._League = self.leagues[indexPath.row]
            destVC._Delegate = self
        }
    }
    
}

extension LeagueListScreen: UITableViewDataSource, UITableViewDelegate{ //Deciding the amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let keysInLeagueDict = Array(LeagueDict.keys) //Keys in our LeagueDictionary
        let currLeagueTitle = keysInLeagueDict[indexPath.row] //The current league index
        let tempLeague = self.LeagueDict[currLeagueTitle] //accessing the dictionary
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueCell
        
        cell.SetLeague(league: tempLeague!) //Specifiying the parameters in the cell
        
        return cell
    }
}

//https://www.youtube.com/watch?v=dsXzy9sDWOQ
