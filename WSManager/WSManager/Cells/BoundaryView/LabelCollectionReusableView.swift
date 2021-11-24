//
//  LabelCollectionReusableView.swift
//  WSManager
//
//  Created by datNguyem on 23/11/2021.
//

import UIKit

final class LabelCollectionReusableView: UICollectionReusableView, ReusableView {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet weak var trailingBtn: UIButton!
    
    func configure(title: String) {
        titleLabel.text = title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
