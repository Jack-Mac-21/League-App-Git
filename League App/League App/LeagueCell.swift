//
//  LeagueCell.swift
//  League App
//
//  Created by JackMac on 12/24/21.
//

import UIKit

class LeagueCell: UITableViewCell {
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var Count: UILabel!
    
    var _League = League(givenTitle: "PlaceHolder")
    
    func SetLeague(league: League){
        Label.text = league.Title
        Count.text = league.Players.count.description
        self._League = league
    }

}
