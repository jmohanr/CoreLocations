//
//  DBVitemsCell.swift
//  CorrentLocation
//
//  Created by Admin on 08/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
protocol DBVitemsCellDelegate{
    func addItemBtnTapped(at index:IndexPath)
     func removeItemBtnTapped(at index:IndexPath)
    func favItemBtnTapped(at index:IndexPath)
}
class DBVitemsCell: UITableViewCell {
     var delegate:DBVitemsCellDelegate!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var addItem: UIButton!
    @IBOutlet weak var removeItem: UIButton!
     @IBOutlet weak var itemCount: UILabel!
     @IBOutlet weak var ratingButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!
    var indexPath:IndexPath!
    @IBAction func addItem(_ sender: UIButton) {
        self.delegate?.addItemBtnTapped(at: indexPath)
    }
    @IBAction func removeItem(_ sender: UIButton) {
        self.delegate?.removeItemBtnTapped(at: indexPath)
    }
    @IBAction func favItem(_ sender: UIButton) {
        self.delegate?.favItemBtnTapped(at: indexPath)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let cgColor: CGColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.18
       contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowColor = cgColor
        contentView.layer.masksToBounds = true
        removeItem.layer.cornerRadius = removeItem.frame.size.height/2
        removeItem.layer.borderWidth = 1.0
        removeItem.layer.borderColor = cgColor
         removeItem.layer.masksToBounds = false
        addItem.layer.cornerRadius = addItem.frame.size.height/2
        addItem.layer.masksToBounds = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        //set the values for top,left,bottom,right margins
        let margins = UIEdgeInsetsMake(10,10, 10, 10)
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, margins)
    }
    
}
