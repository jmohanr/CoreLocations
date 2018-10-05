//
//  BlurImageCell.swift
//  CorrentLocation
//
//  Created by Admin on 04/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class BlurImageCell: UITableViewCell {
   
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var itemCountBtn: UIButton!
    @IBOutlet weak var playImage: UIImageView!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var bagroundImage: UIImageView!
    @IBOutlet weak var forwardBtn: UIButton!
    @IBOutlet weak var backwardBtn: UIButton!
    @IBOutlet weak var zoomBtn: UIButton!
    @IBOutlet weak var temperatursBtn: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addingCornerRadius(sender: itemCountBtn)
        addingCornerRadius(sender: playImage)
        addingCornerRadius(sender: blurView)
        addingCornerRadius(sender: playButton)
        bagroundImage.layer.cornerRadius = 20.0
        bagroundImage.layer.masksToBounds = true
       
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = blurView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addingCornerRadius(sender: blurEffectView)
        blurView.addSubview(blurEffectView)
        blurEffectView.bringSubview(toFront: blurView)
        blurEffectView.contentView.addSubview(playButton)
        blurEffectView.contentView.addSubview(temperatureLabel)
        blurEffectView.contentView.addSubview(temperatursBtn)
        blurEffectView.contentView.addSubview(zoomBtn)
        blurEffectView.contentView.addSubview(backwardBtn)
        blurEffectView.contentView.addSubview(forwardBtn)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func addingCornerRadius(sender:Any){
        (sender as AnyObject).layer.cornerRadius = (sender as AnyObject).frame.size.height/2
        (sender as AnyObject).layer.masksToBounds = true
    }

}
