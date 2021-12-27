//
//  PlayerScoreScreen.swift
//  League App
//
//  Created by JackMac on 12/26/21.
//

import UIKit

class PlayerScoreScreen: UIViewController {
    @IBOutlet weak var ScoreTableView: UITableView!
    @IBOutlet weak var PlayerName: UILabel!
    
    var givenName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreTableView.delegate = self
        ScoreTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        PlayerName.text = givenName
    }

}

extension PlayerScoreScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 18
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tempHole = Hole()
        
        tempHole.HoleNumber = indexPath.row + 1
        
        print(tempHole.HoleNumber)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HoleCustomCell") as! HoleScoreCell
        
        cell.setHole(hole: tempHole)
        return cell
    
    }
    
}


