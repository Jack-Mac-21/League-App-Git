//
//  LeagueCell.swift
//  League App
//
//  Created by JackMac on 12/24/21.
//

import UIKit

//For each cell that has the league name
// and the amount of players in the league on the
// right
class LeagueCell: UITableViewCell {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Count: UILabel!
    
    var _League = League(givenTitle: "PlaceHolder")
    
    func SetLeague(league: League){
        Label.text = league.Title
        Count.text = league.PlayersDict.count.description
        self._League = league
    }

}
