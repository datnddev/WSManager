//
//  ServicesCollectionViewCell.swift
//  WSManager
//
//  Created by datNguyem on 24/11/2021.
//

import UIKit

final class FeatureCollectionViewCell: UICollectionViewCell, ReusableView {
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(feature: String?) {
        titleLabel.text = feature
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
