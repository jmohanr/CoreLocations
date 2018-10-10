//
//  DBItemDetailsVC.swift
//  CorrentLocation
//
//  Created by Admin on 09/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//
struct itemDetails {
    var name:String
    var image:UIImage
    var itemPrice:String
    var itemDetails:String
    var status:String
    var discountPrice:String
}
struct vitems {
    var itemName:String
    var itemImage:UIImage
    var Price:Int
    var itemDesc:String
    
}
import UIKit

class DBItemDetailsVC: UIViewController {
    var detailData = [itemDetails]()
    var vDetails = [vitems]()
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var ratinglabel: UILabel!
    @IBOutlet weak var subNamelbl: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var placeHolderimage: UIImageView!
    @IBOutlet weak var bgimage: UIImageView!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placeHolderimage.layer.cornerRadius = self.placeHolderimage.frame.size.height/2
        self.placeHolderimage.layer.masksToBounds = true
        shareBtn.setRadius()
        starBtn.setRadius()
        moreBtn.setRadius()
        playBtn.setRadius()
        if detailData.count > 0 {
            for i in 0..<detailData.count {
                let objc = detailData[i]
                bgimage.image = objc.image
                nameLabel.text = objc.name
                descTextView.text = objc.itemDetails
                placeHolderimage.image = objc.image
                ratinglabel.text = objc.itemPrice
                statusLabel.text = objc.status
                
            }
        } else{
            for i in 0..<vDetails.count {
                let objc = vDetails[i]
               bgimage.image = objc.itemImage
                nameLabel.text = objc.itemName
                descTextView.text = objc.itemDesc
                placeHolderimage.image = objc.itemImage
                ratinglabel.text = String(objc.Price)
//                statusLabel.text = objc.status
                
            }
        }
        
    }
    @IBAction func backBtnAction(_ sender: Any) {
        self .dismiss(animated: true, completion: nil)
    }
    @IBAction func shareBtnAction(_ sender: Any) {
    }
    
    @IBAction func starBtnAction(_ sender: Any) {
    }
    @IBAction func moreBtnAction(_ sender: Any) {
    }
    
    @IBAction func playBtnAction(_ sender: Any) {
    }
}
