//
//  UsersDataTableViewCell.swift
//  OnTheMap
//
//  Created by khawlah on 1/19/19.
//  Copyright © 2019 khawlah. All rights reserved.
//

import UIKit

class UsersDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func fillCell(usersData: Results) {
        
        if let frist = usersData.firstName , let last = usersData.lastName , let url = usersData.mediaURL {
            
            fullNameLabel.text = "\(frist) \(last)"
            urlLabel.text = "\(url)"
            
        }
    }
}
