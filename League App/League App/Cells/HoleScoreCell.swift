//
//  HoleScoreCell.swift
//  League App
//
//  Created by JackMac on 12/26/21.
//

import UIKit

class HoleScoreCell: UITableViewCell {

    @IBOutlet weak var HoleNum: UILabel!
    @IBOutlet weak var ScoreLabel: UILabel!
    @IBOutlet weak var ParLabel: UILabel!
    
    @IBOutlet weak var ParStepper: UIStepper!
    @IBOutlet weak var ScoreStepper: UIStepper!
    
    var givenHole = Hole()
    
    @IBAction func stepperParValueChanged(_ sender: UIStepper){
        ParLabel.text = Int(sender.value).description
    }
    
    @IBAction func stepperScoreValueChanged(_ sender: UIStepper) {
        ScoreLabel.text = Int(sender.value).description
    }
    
    
    
    func setHole(hole: Hole){
        HoleNum.text = "Hole #" + (hole.HoleNumber.description)
        ScoreLabel.text = hole.Score.description
        ParLabel.text = hole.ParNumber.description
        givenHole = hole
    }
    

}
