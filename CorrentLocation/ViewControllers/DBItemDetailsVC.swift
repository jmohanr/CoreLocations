//
//  DBItemDetailsVC.swift
//  CorrentLocation
//
//  Created by Admin on 09/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class DBItemDetailsVC: UIViewController {
var itemname = String()
    
    @IBOutlet weak var itemImage: UIImageView!
    var imageName = UIImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        itemImage.image = imageName
print(itemname)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
