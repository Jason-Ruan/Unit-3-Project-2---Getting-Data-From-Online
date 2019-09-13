//
//  SeriesTableViewCell.swift
//  Unit 3 Project 2
//
//  Created by Jason Ruan on 9/10/19.
//  Copyright © 2019 Jason Ruan. All rights reserved.
//

import UIKit

class SeriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesTitle: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
