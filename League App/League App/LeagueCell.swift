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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func SetLeague(league: League){
        Label.text = league.Title
    }

}
