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

class PlayerScoreScreen: UIViewController, DataPlayerScore {
    @IBOutlet weak var ScoreTableView: UITableView!
    @IBOutlet weak var PlayerName: UILabel!
    
    var givenName: String?
    var givenHoles: [Hole]?
    var dataDelegate: DataDelegatePlayerListScreen?
    var currPlayer: Player! //Player needs to be set or crash
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreTableView.delegate = self
        ScoreTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PlayerName.text = givenName
    }
    
    func UpdatePar(index: Int, value: Int) {
        currPlayer?.ParNums[index] = value
    }
    
    func UpdateScore(index: Int, value: Int){
        currPlayer?.Scores[index] = value
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let score = currPlayer.Scores[indexPath.row]
        let par = currPlayer.ParNums[indexPath.row]
        
        let tempHole = Hole()
        
        tempHole.Score = score
        tempHole.ParNumber = par
        tempHole.HoleNumber = indexPath.row + 1
        
        print(tempHole.HoleNumber)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoleCustomCell") as! HoleScoreCell
        
        cell.setHole(hole: tempHole)
        cell.scoreDelegate = self
        
        return cell
    
    }
    
}


