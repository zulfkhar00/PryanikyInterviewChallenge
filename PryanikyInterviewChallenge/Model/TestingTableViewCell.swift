//
//  TestingTableViewCell.swift
//  PryanikyInterviewChallenge
//
//  Created by Zulfkhar Maukey on 15/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import UIKit

class TestingTableViewCell: UITableViewCell {

    @IBOutlet var optionButtons: [UIButton]!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
