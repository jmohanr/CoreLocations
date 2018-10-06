//
//  SlideViewController.swift
//  CorrentLocation
//
//  Created by Admin on 06/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//
struct collectionData {
    var title:String
    var subTitle:String
    var profileImage:UIImage
}
import UIKit

class SlideViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var totalData = [collectionData]()

    @IBOutlet weak var flowLayOuts: UICollectionViewFlowLayout!
    @IBOutlet weak var heightConstaint: NSLayoutConstraint!
    @IBOutlet weak var colectionView: UICollectionView!
    @IBOutlet weak var bgImage: UIImageView!
    var oldFrame = CGRect()
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = UICollectionViewScrollDirection.horizontal
        colectionView.setCollectionViewLayout(layout1, animated: true)
        colectionView.delegate = self
        colectionView.dataSource = self
        oldFrame = colectionView.frame
        totalData = [collectionData.init(title: "Michel", subTitle: "Jackson", profileImage: #imageLiteral(resourceName: "michel")),
        collectionData.init(title: "Virat", subTitle: "Kohli",profileImage: #imageLiteral(resourceName: "kh")),
        collectionData.init(title: "Zaheer", subTitle: "Khan",profileImage: #imageLiteral(resourceName: "zaheer")),
        collectionData.init(title: "Yuvaraj", subTitle: "Singh",profileImage: #imageLiteral(resourceName: "uv")),
        collectionData.init(title: "Rishab", subTitle: "Panth",profileImage: #imageLiteral(resourceName: "rishab")),
        collectionData.init(title: "Ab", subTitle: "Develiers",profileImage: #imageLiteral(resourceName: "abd"))]
       bgImage.image = #imageLiteral(resourceName: "kohli")
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return totalData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.titleLabel.text = totalData[indexPath.row].title
         cell.subTitleLabel.text = totalData[indexPath.row].subTitle
        cell.profileImage.image = totalData[indexPath.row].profileImage
        UIView.animate(withDuration: 15.0, delay: 0.0, options: .curveLinear, animations: {
            cell.profileImage.transform = cell.profileImage.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 1.0) {
            self.bgImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
             self.bgImage.image = self.totalData[indexPath.row].profileImage
        }
    }

}
