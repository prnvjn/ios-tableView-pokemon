//
//  TableViewCell.swift
//  ios101-project5-tumblr
//
//  Created by Pranav J on 10/16/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imageUrl: UIImageView!
    @IBOutlet weak var summary: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
