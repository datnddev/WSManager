//
//  FieldTypeTableViewCell.swift
//  WSManager
//
//  Created by datNguyem on 23/11/2021.
//

import UIKit
import DropDown

class FieldTypeTableViewCell: DropDownCell, ReusableView {
    @IBOutlet weak var sportImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
