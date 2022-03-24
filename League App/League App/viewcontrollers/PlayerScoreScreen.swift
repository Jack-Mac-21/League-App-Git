//
//  PlayerScoreScreen.swift
//  League App
//
//  Created by JackMac on 12/26/21.
//

import UIKit

protocol DataPlayerScore{
    func UpdatePar(index: Int, value: Int) //Index to know what hole to index for and an updated value
    func UpdateScore(index: Int, value: Int)
}


//The view for an individual player,
//This is the screen that updates
class PlayerScoreScreen: UIViewController, DataPlayerScore {
    @IBOutlet weak var ScoreTableView: UITableView!
    @IBOutlet weak var PlayerName: UILabel!
    @IBOutlet weak var GrossScoreText: UILabel!
    @IBOutlet weak var NetScoreText: UILabel!
    @IBOutlet weak var PlayersLeagueLabel: UILabel!
    
    var givenName: String?
    var givenHoles: [Hole]?
    var dataDelegate: DataDelegatePlayerListScreen?
    var currPlayer: Player! //Player needs to be set or crash
    var totalPar: Int!
    var totalScore: Int!
    var givenLeague: League?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreTableView.delegate = self
        ScoreTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PlayerName.text = givenName
        PlayersLeagueLabel.text = "League: " + givenLeague!.Title
        updateCalculatedScores()
        
    }
    
    func UpdatePar(index: Int, value: Int) {
        
        currPlayer?.ParNums[index] = value
        var total = 0;
        var i = 0 as Int;
        for num in currPlayer.ParNums{
            if currPlayer.Scores[i] > 0 {
                total += num;
            }
            i += 1;
        }
        totalPar = total
        updateCalculatedScores()
    }
    
    func UpdateScore(index: Int, value: Int){
        currPlayer?.Scores[index] = value;
        let parVal = currPlayer?.ParNums[index];
        UpdatePar(index: index, value: parVal!)
        var total = 0
        for num in currPlayer.Scores{
            total += num
        }
        totalScore = total
        updateCalculatedScores()
    }
    func updateCalculatedScores(){
        GrossScoreText.text = "Gross: " + totalScore.description
        NetScoreText.text = "Over Par: " + (totalScore - totalPar).description
    }
    
    //Supposed to call when the view will move
    //ie when the back button is pressed
    //for updating the player values
    func willMove(toParent parent: PlayerScoreScreen?) {
        super.willMove(toParent: parent)

        if parent == nil {
            dataDelegate?.updatePlayer(player: currPlayer)
        }
    }

}

extension PlayerScoreScreen: UITableViewDelegate, UITableViewDataSource {
    
    //18 Sections for 18 holes
    func numberOfSections(in tableView: UITableView) -> Int {
        return 18
    }
    
    //Only have 1 row because the sections will be for each hole
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let score = currPlayer.Scores[indexPath.section]
        let par = currPlayer.ParNums[indexPath.section]
        
        let tempHole = Hole()
        
        tempHole.Score = score
        tempHole.ParNumber = par
        tempHole.HoleNumber = indexPath.section + 1
        
        print(tempHole.HoleNumber)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoleCustomCell") as! HoleScoreCell
        
        cell.setHole(hole: tempHole)
        cell.scoreDelegate = self
        
        if score == 0{
            cell.backgroundColor = UIColor.gray
        }else{
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    
    
}


