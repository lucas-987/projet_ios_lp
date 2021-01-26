//
//  TodoTableViewCell.swift
//  to_do_TREYER_VANDAELE
//
//  Created by treyer lucas on 04/01/2021.
//  Copyright © 2021 treyer lucas. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoButtonDone: UIButton!
    
    var toDoTask: ToDoTask!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
