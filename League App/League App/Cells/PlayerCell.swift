//
//  PlayerCell.swift
//  League App
//
//  Created by JackMac on 12/19/21.
//

import Foundation
import UIKit

class PlayerCell: UITableViewCell{
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Skill: UILabel!
    @IBOutlet weak var Age: UILabel!
    
    func setPlayer(player: Player){
        Name.text = player.Name
        Skill.text = player.SkillLevel.description
        Age.text = player.Age.description
        
    }
}
