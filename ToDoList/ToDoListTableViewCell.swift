//
//  ToDoListTableViewCell.swift
//  ToDoList
//
//  Created by Egor on 28.06.17.
//  Copyright © 2017 Egor. All rights reserved.
//

import UIKit

class ToDoListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var checkMarkImageView: UIImageView!
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //checkMarkImageView.isHidden = false
        // Configure the view for the selected state
    }

}

