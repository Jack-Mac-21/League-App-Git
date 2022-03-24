//
//  PlayerCell.swift
//  League App
//
//  Created by JackMac on 12/19/21.
//

import Foundation
import UIKit

//The cell that has the name of the player and
//there score data displayed on the right
class PlayerCell: UITableViewCell, DataDelegatePlayerListScreen{
    @IBOutlet weak var Name: UILabel!
    
    //Totals
    @IBOutlet weak var GrossLabel: UILabel!
    @IBOutlet weak var OverParLabel: UILabel!
    
    //Front 9
    @IBOutlet weak var FrontGrossLabel: UILabel!
    @IBOutlet weak var FrontOverParLabel: UILabel!
    
    //Back 9
    @IBOutlet weak var BackGrossLabel: UILabel!
    @IBOutlet weak var BackOverParLabel: UILabel!
    
    
    var givenPlayer: Player?
    
    func setPlayer(player: Player){
        Name.text = player.Name
        player.calcScores()
        
        GrossLabel.text = player.GrossScore?.description
        OverParLabel.text =  player.OverParScore?.description
        
        FrontGrossLabel.text = player.Front9Gross?.description
        FrontOverParLabel.text = player.Front9OverPar?.description
        
        BackGrossLabel.text = player.Back9Gross?.description
        BackOverParLabel.text = player.Back9OverPar?.description
        
        
    }
    
    func updatePlayer(player: Player) {
        player.calcScores()
        
        GrossLabel.text = "Gross: " + (player.GrossScore?.description ?? "Error")
        OverParLabel.text = "Over Par: " + (player.OverParScore?.description ?? "Error")
        
        FrontGrossLabel.text = player.Front9Gross?.description
        FrontOverParLabel.text = player.Front9OverPar?.description
        
        BackGrossLabel.text = player.Back9Gross?.description
        BackOverParLabel.text = player.Back9OverPar?.description
        
    }
}
