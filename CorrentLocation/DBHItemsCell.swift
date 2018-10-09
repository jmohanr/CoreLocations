//
//  DBHItemsCell.swift
//  CorrentLocation
//
//  Created by Admin on 08/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DBHItemsCell: UICollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemStatusLabel: UILabel!
     @IBOutlet weak var itemDiscountPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        itemStatusLabel.layer.cornerRadius = 5.0
//        itemStatusLabel.layer.masksToBounds = true
    }

}
