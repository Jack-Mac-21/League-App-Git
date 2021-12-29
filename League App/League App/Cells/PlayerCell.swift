//
//  PlayerCell.swift
//  League App
//
//  Created by JackMac on 12/19/21.
//

import Foundation
import UIKit

class PlayerCell: UITableViewCell, DataDelegatePlayerListScreen{
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var GrossLabel: UILabel!
    @IBOutlet weak var OverParLabel: UILabel!
    
    var givenPlayer: Player?
    
    func setPlayer(player: Player){
        Name.text = player.Name
        
    }
    
    func updatePlayer(player: Player) {
        givenPlayer = player
        givenPlayer?.calcScores()
        GrossLabel.text = givenPlayer?.GrossScore?.description
        OverParLabel.text = givenPlayer?.OverParScore?.description
    }
}
