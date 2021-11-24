//
//  PriceFieldCollectionViewCell.swift
//  WSManager
//
//  Created by datNguyem on 23/11/2021.
//

import UIKit

final class PriceFieldCollectionViewCell: UICollectionViewCell, ReusableView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var priceUiView: UIView!
    
    func configure(price: Price) {
        timeLabel.text = "\(price.start) - \(price.end)"
        priceLabel.text = "\(price.price.convertToVND()!)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        priceUiView.layer.cornerRadius = 5
    }
}
