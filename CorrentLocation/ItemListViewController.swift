//
//  ItemListViewController.swift
//  CorrentLocation
//
//  Created by Admin on 06/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//
struct hItemsData {
    var name:String
    var image:UIImage
    var itemPrice:String
    var itemDetails:String
    var status:String
    var discountPrice:String
    
}
struct vItemsData {
    var itemName:String
    var itemImage:UIImage
    var Price:Int
    var itemDesc:String
    
    
}
import UIKit
import MapKit
import CoreLocation

class ItemListViewController: UIViewController {
    var hItemDetails = [hItemsData]()
    var vItemDetails = [vItemsData]()
    var initialPrice = Int()
    var InitialItemCount = Int()
     let locationManager = CLLocationManager()
     @IBOutlet weak var flowLayOut: UICollectionViewFlowLayout!
    @IBOutlet weak var heightConstrain: NSLayoutConstraint!
    @IBOutlet weak var addressLabel: UILabel!
     @IBOutlet weak var collectionView: UICollectionView!
     @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hItemDetails = [hItemsData(name: "Avagadro", image: #imageLiteral(resourceName: "images-11"), itemPrice: "₹200", itemDetails: "The avocado is a tree, long thought ", status: "OPEN", discountPrice: "₹50"),
                        hItemsData(name: "WaterMilon", image: #imageLiteral(resourceName: "images-12"), itemPrice: "₹120", itemDetails: "Citrullus lanatus is a plant species in the family Cucurbitaceae,.", status: "FUTURE", discountPrice: "₹10"),
                        hItemsData(name: "PineApple", image: #imageLiteral(resourceName: "images-13"), itemPrice: "₹150", itemDetails: "The pineapple is a tropical plant with an edible multiple fruit ", status: "OPEN", discountPrice: "₹25"),
                        hItemsData(name: "Banana", image: #imageLiteral(resourceName: "images-14"), itemPrice: "₹80", itemDetails: "A banana is an edible fruit – botanically a berry " , status: "CLOSE", discountPrice: "₹15"),
                        hItemsData(name: "Pomegranate", image: #imageLiteral(resourceName: "images-15"), itemPrice: "₹400", itemDetails: "The pomegranate is a fruit-bearing deciduous shrub or small tree in the family.", status: "SOON", discountPrice: "₹100")]
        
        vItemDetails = [vItemsData(itemName: "Cherries", itemImage: #imageLiteral(resourceName: "cherry"), Price: 200, itemDesc: "A cherry is the fruit of many plants of the genus Prunus, and is a fleshy drupe.  sweet cherry and the sour cherry "),
                        vItemsData(itemName: "Pluot", itemImage: #imageLiteral(resourceName: "Pluots"), Price: 120, itemDesc: "Pluots, apriums, apriplums, or plumcots, are some of the hybrids between different Prunus species that are also called interspecific plums"),
                        vItemsData(itemName: "Gooseberry", itemImage: #imageLiteral(resourceName: "Goosebarry"), Price: 150, itemDesc: "The gooseberry, with scientific names Ribes uva-crispa, is a species of Ribes "),
                        vItemsData(itemName: "Elderberry", itemImage: #imageLiteral(resourceName: "Elderberry"), Price: 80, itemDesc: "Sambucus is a genus of flowering plants in the family Adoxaceae." ),
                        vItemsData(itemName: "Peach", itemImage: #imageLiteral(resourceName: "Peach"), Price: 400, itemDesc: "The peach is a deciduous tree native to the region of Northwest China between the Tarim Basin and the north slopes of the Kunlun Mountains")]
        
        
        let layout1 = UICollectionViewFlowLayout()
        layout1.scrollDirection = UICollectionViewScrollDirection.horizontal
        collectionView.setCollectionViewLayout(layout1, animated: true)
        collectionView.register(UINib(nibName: "DBHItemsCell", bundle: .main), forCellWithReuseIdentifier: "DBHItemsCell")
        tableView.register(UINib(nibName: "DBVitemsCell", bundle: nil), forCellReuseIdentifier: "DBVitemsCell")
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
       // startTimer()
    }
}
extension ItemListViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hItemDetails.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DBHItemsCell", for: indexPath) as! DBHItemsCell
        cell.backgroundColor = UIColor.white
        cell.itemName.text = hItemDetails[indexPath.row].name
        cell.itemPrice.text = hItemDetails[indexPath.row].itemPrice
        cell.itemStatusLabel.text = hItemDetails[indexPath.row].status
        cell.itemDesc.text = hItemDetails[indexPath.row].itemDetails
        cell.itemImage.image = hItemDetails[indexPath.row].image
        cell.itemDiscountPrice.text = hItemDetails[indexPath.row].discountPrice
       
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 290, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
   
        let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "DBItemDetailsVC") as! DBItemDetailsVC
        viewcontroller.itemname = hItemDetails[indexPath.row].name
        //imageName
         viewcontroller.imageName  = hItemDetails[indexPath.row].image
        self.present(viewcontroller, animated: true, completion: nil)
    }
}
extension ItemListViewController:UITableViewDataSource,UITableViewDelegate,DBVitemsCellDelegate{
    func favItemBtnTapped(at index: IndexPath) {
        let cell = tableView.cellForRow(at: index) as! DBVitemsCell
        if cell.menuButton.currentImage == #imageLiteral(resourceName: "Fav") {
            cell.menuButton.setImage(#imageLiteral(resourceName: "unFav"), for: .normal)
        } else{
            cell.menuButton.setImage(#imageLiteral(resourceName: "Fav"), for: .normal)
        }
    }
    
    func addItemBtnTapped(at index: IndexPath) {
        let _ = tableView.cellForRow(at: index) as! DBVitemsCell
    }
    
    func removeItemBtnTapped(at index: IndexPath) {
        let _ = tableView.cellForRow(at: index) as! DBVitemsCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vItemDetails.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DBVitemsCell") as! DBVitemsCell
         cell.contentView.frame = UIEdgeInsetsInsetRect(cell.contentView.frame, UIEdgeInsetsMake(10, 10, 10, 10))
        cell.contentView.backgroundColor = UIColor.white
        cell.backgroundColor = UIColor.clear
        cell.delegate = self
        cell.indexPath = indexPath
        cell.removeItem.isHidden = true
       
        cell.itemImage.image = vItemDetails[indexPath.row].itemImage
         cell.itemName.text = vItemDetails[indexPath.row].itemName
        cell.itemPrice.text = "₹\(vItemDetails[indexPath.row].Price)"
        cell.itemDesc.text = vItemDetails[indexPath.row].itemDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heightOfRow = heightForText(text: vItemDetails[indexPath.row].itemDesc, Font: UIFont(name: "Helvetica Neue", size: 12.0)!, Width: self.tableView.frame.size.width)
        return heightOfRow + 190.0
    }
    
    func heightForText(text: String,Font: UIFont,Width: CGFloat) -> CGFloat{
        
        let constrainedSize = CGSize.init(width:Width, height: CGFloat(MAXFLOAT))
        
        let attributesDictionary = NSDictionary.init(object: Font, forKey:NSAttributedStringKey.font as NSCopying)
        
        let mutablestring = NSAttributedString.init(string: text, attributes: attributesDictionary as? [NSAttributedStringKey : Any])
        
        var requiredHeight = mutablestring.boundingRect(with:constrainedSize, options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), context: nil)
        
        if requiredHeight.size.width > Width {
            requiredHeight = CGRect.init(x: 0, y: 0, width: Width, height: requiredHeight.height)

        }
        return requiredHeight.size.height;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewcontroller = storyboard?.instantiateViewController(withIdentifier: "DBItemDetailsVC") as! DBItemDetailsVC
        //viewcontroller.hero = artistList[indexPath.row]
        self.present(viewcontroller, animated: true, completion: nil)
    }
}
extension ItemListViewController :CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.requestLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if let location = locations.first {
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemark, error) in
                if error == nil {
                    let firstLocation = placemark?[0]
                    let totalAddress = "\(firstLocation?.name ?? "")," + "\(firstLocation?.locality ?? "")," + "\(firstLocation?.administrativeArea ?? "")"
                    self.addressLabel.text = totalAddress
                }
                else {
                    print(error!)
                }
            }
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    @objc func scrollToNextCell(){
        
        //get Collection View Instance
     
        
        //get cell size
      
        let cellSize = CGSize(width: 270, height: 280)
        
        //get current content Offset of the Collection view
        let contentOffset = collectionView.contentOffset;
        
        //scroll to next cell
//        collectionView.scrollRectToVisible(CGRectMake(contentOffset.x + cellSize.width, contentOffset.y, cellSize.width, cellSize.height), animated: true);
        collectionView.scrollRectToVisible(CGRect(x: contentOffset.x + cellSize.width , y: contentOffset.y, width: cellSize.width, height: cellSize.height), animated: true)
     
        
        
    }
    func startTimer() {
        

         Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.scrollToNextCell), userInfo: nil, repeats: true)
        
        
    }
}
