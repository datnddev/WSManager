//
//  ImageFieldCollectionViewCell.swift
//  WSManager
//
//  Created by datNguyem on 24/11/2021.
//

import UIKit

final class ImageFieldCollectionViewCell: UICollectionViewCell, ReusableView {
    @IBOutlet private weak var fieldImageView: UIImageView!
    
    func configure(image: UIImage) {
        fieldImageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
