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
protocol SaveDataDelegate{
    func SaveCurrData()
}


//The view that shows all of the leagues layed out in a list
class LeagueListScreen: UIViewController, DataDelegate {
    @IBOutlet weak var AddLeagueButton: UIButton!
    @IBOutlet weak var LeagueNameInput: UITextField!
    @IBOutlet weak var LeagueTableView: UITableView!
    
    var LeagueDict = [String: League]()
    var AddedLeague = League(givenTitle: "NULL987654321")  //Just used to make sure the added league
    //appears correctly right away
    
    //Protocol Implementation to pass data back to this screen
    func updateLeague(league: League, player: Player){
        AddPlayerToLeague(givenLeague: league, givenPlayer: player)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadLeague() //Initializes the variables
        LeagueTableView.reloadData()
        LeagueTableView.delegate = self
        LeagueTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    //reloads the table view cell with new data
    override func viewWillAppear(_ animated: Bool) {
        LeagueTableView.reloadData()
        saveDataLocally()
    }
    
    //Adds league from input fields
    //When the user hits the Add League UIButton
    @IBAction func AddLeague(_ sender: Any) {
        let tempLeague = League(givenTitle: LeagueNameInput.text ?? "error")
        if LeagueDict[tempLeague.Title] == nil{
            LeagueDict[tempLeague.Title] = tempLeague
            
            self.AddedLeague = tempLeague
            LeagueTableView.beginUpdates()
            LeagueTableView.insertRows(at: [IndexPath(row: self.LeagueDict.count - 1, section: 0)], with: .automatic) /// animate the insertion
            LeagueTableView.endUpdates()
            
            LeagueNameInput.text = ""
            
            self.AddedLeague = League(givenTitle: "NULL987654321")
        }
        else{
            UserDefaults.standard.set(nil, forKey: "GetLeagueDict")
        }

    }
    
    @IBAction func SaveButtonPressed(_ sender: Any) {
        saveDataLocally()
    }
    
    
    //Function testing if we are adding player from the player list screen
    //Need to update to update the correspounding league with the new player
    func AddPlayerToLeague(givenLeague: League, givenPlayer: Player){
        LeagueDict[givenLeague.Title]?.PlayersDict[givenPlayer.Name] = givenPlayer //Adds a given player to the given league
        
    }
    
    //preparing for the segue to the player list
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LeaguesToLeague"{
            let selectedLeagueCell = LeagueTableView.cellForRow(at: LeagueTableView.indexPathForSelectedRow!) as! LeagueCell
            let currLeagueName = selectedLeagueCell.Label.text
            let destVC = segue.destination as! PlayerListScreen
            
            destVC._League = self.LeagueDict[currLeagueName!]
            destVC._DelegateForLeague = self
        }
    }
    
    //Saves the data when the view disappears
    override func viewWillDisappear(_ animated: Bool) {
        saveDataLocally()
    }
    
    func saveDataLocally(){
        let encodedData = try? JSONEncoder().encode(LeagueDict)
        UserDefaults.standard.set(encodedData, forKey: "GetLeagueDict")
        print("Called view will disappear")
    }
    
    //Loads the league if it is there
    func loadLeague(){
        let data = UserDefaults.standard.value(forKey: "GetLeagueDict") as? Data
        if data != nil{
            let decodedDict = try? JSONDecoder().decode([String: League].self, from: data!)
            if decodedDict != nil {
                LeagueDict = decodedDict!
            
            }
            else{
                print("DecodedDict was decoded as nil")
            }
        }
        else{
            print("data value was nil")
        }
    }
}

extension LeagueListScreen: UITableViewDataSource, UITableViewDelegate{ //Deciding the amount of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.LeagueDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let keysInLeagueDict = Array(LeagueDict.keys) //Keys in our LeagueDictionary
        let currLeagueTitle = keysInLeagueDict[indexPath.row] //The current league index
        let tempLeague = self.LeagueDict[currLeagueTitle] //accessing the dictionary
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCell") as! LeagueCell
        
        if self.AddedLeague.Title == "NULL987654321"{
            cell.SetLeague(league: tempLeague!) //Specifiying the parameters in the cell
        }
        else{
            cell.SetLeague(league: self.AddedLeague)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            
            let cell = tableView.cellForRow(at: indexPath) as! LeagueCell
            
            let leagueName = cell.Label.text
            
            LeagueDict.removeValue(forKey: leagueName!)

            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
}

//https://www.youtube.com/watch?v=dsXzy9sDWOQ
