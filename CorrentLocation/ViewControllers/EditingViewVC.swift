//
//  EditingViewVC.swift
//  CorrentLocation
//
//  Created by Admin on 04/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

struct tableViewData {
    var names:String
    var Images:String
    var count:String
    var temPerature:String
}
import UIKit
import AVKit
class EditingViewVC: UIViewController,AVPlayerViewControllerDelegate {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var btmImage: UIImageView!
    @IBOutlet weak var circularBtn: UIButton!
    @IBOutlet weak var deviceBtn: UIButton!
    @IBOutlet weak var libraryBtn: UIButton!
    @IBOutlet weak var deviceLabel: UILabel!
    @IBOutlet weak var libraryLabel: UILabel!
    var totalData = [tableViewData]()
var count = Int()
    var isSelected = Bool()
    @IBOutlet weak var tableView: UITableView!
    var player = AVPlayer()
    override func viewDidLoad() {
        super.viewDidLoad()
       circularBtn.layer.cornerRadius = circularBtn.frame.size.height/2
        circularBtn.layer.masksToBounds = true
        totalData = [tableViewData(names: "House Entrence", Images: "music1", count: "5", temPerature: "35 C"),tableViewData(names: "Kitchen", Images: "music2", count: "9", temPerature: "30 C"),tableViewData(names: "Hall", Images: "music3", count: "2", temPerature: "25 C"),tableViewData(names: "Bed Room", Images: "music4", count: "0", temPerature: "28 C"),tableViewData(names: "Dining Hall", Images: "music5", count: "1", temPerature: "20 C"),tableViewData(names: "Singing Room", Images: "music6", count: "3", temPerature: "28 C"),tableViewData(names: "Balcony", Images: "music7", count: "4", temPerature: "32 C")]
    }
    
    @IBAction func libraryBtnAction(_ sender: Any) {
        deviceBtn.setImage(#imageLiteral(resourceName: "device"), for: .normal)
        libraryBtn.setImage(#imageLiteral(resourceName: "S.Libra"), for: .normal)
        libraryLabel.textColor = UIColor.darkGray
        deviceLabel.textColor = UIColor.black.withAlphaComponent(0.8)
        
    }
    @IBAction func circularBtnAction(_ sender: Any) {
        
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .transitionCurlDown, animations: {
            self.sideView.isHidden = false
            let rectShape1 = CAShapeLayer()
            rectShape1.bounds = self.sideView.frame
            rectShape1.position = self.sideView.center
            rectShape1.path = UIBezierPath(roundedRect: self.sideView.bounds, byRoundingCorners: [UIRectCorner.topLeft], cornerRadii: CGSize(width: 250.0, height: 0.0)).cgPath
            self.sideView.layer.mask = rectShape1
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = self.sideView.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.sideView.addSubview(blurEffectView)
            blurEffectView.bringSubview(toFront: self.sideView)
            blurEffectView.contentView.addSubview(self.closeBtn)
            blurEffectView.contentView.addSubview(self.img)
        }, completion: nil)
        
        
    }
    @IBAction func closeBtnAction(_ sender: Any) {
         self.sideView.isHidden = true
    }
    @IBAction func devicesBtnAction(_ sender: Any) {
        deviceBtn.setImage(#imageLiteral(resourceName: "Sdevice"), for: .normal)
        libraryBtn.setImage(#imageLiteral(resourceName: "Library"), for: .normal)
        deviceLabel.textColor = UIColor.darkGray
    libraryLabel.textColor = UIColor.black.withAlphaComponent(0.8)
    }
}
extension EditingViewVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlurImageCell") as! BlurImageCell
        cell.bagroundImage.image = UIImage(named: totalData[indexPath.row].Images)
        cell.nameLabel.text = totalData[indexPath.row].names
        cell.itemCountBtn.setTitle(totalData[indexPath.row].count, for: .normal)
        cell.temperatureLabel.text = totalData[indexPath.row].temPerature
        
        let videoURL = URL(string: "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")
       player = AVPlayer(url: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = cell.bagroundImage.bounds
       
        if count >= 0 {
            if indexPath.row == count && isSelected == true{
                cell.itemCountBtn.backgroundColor = UIColor.red
                cell.blurView.isHidden = false
                cell.liveLabel.isHidden = false
                cell.colorLabel.isHidden = false
                cell.playImage.isHidden = true
                 cell.bagroundImage.layer.addSublayer(playerLayer)
            } else{
                cell.itemCountBtn.backgroundColor = UIColor.orange
                cell.blurView.isHidden = true
                cell.liveLabel.isHidden = true
                 cell.colorLabel.isHidden = true
                cell.playImage.isHidden = false
                cell.bagroundImage.layer.sublayers?.removeAll()
            }
            
        } else{
            cell.itemCountBtn.backgroundColor = UIColor.orange
            cell.blurView.isHidden = true
            cell.liveLabel.isHidden = true
             cell.colorLabel.isHidden = true
            cell.playImage.isHidden = false
        }
        cell.playButton.addTarget(self, action: #selector(EditingViewVC.playVideo(sender:)), for:.touchUpInside)
         cell.zoomBtn.addTarget(self, action: #selector(EditingViewVC.playVideoPlayerController(sender:)), for:.touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = tableView.indexPathForSelectedRow
        count = (index?.row)!
        isSelected = true
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @objc func playVideo(sender:UIButton){
        if sender.tag == 1 {
            player.pause()
            sender.setImage(#imageLiteral(resourceName: "icons8-pause"), for: .normal)
            sender.tag = 0
        }else{
            player.play()
            sender.setImage(#imageLiteral(resourceName: "icons8-play"), for: .normal)
            sender.tag = 1
        }
        
    }
    @objc func playVideoPlayerController(sender:UIButton){
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
}
