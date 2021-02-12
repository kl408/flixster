//
//  MovieCell.swift
//  flixster
//
//  Created by Kristy Lau on 2/11/21.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var synopsisLabel: UILabel!
    
    @IBOutlet var posterView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}