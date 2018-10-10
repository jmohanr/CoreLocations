//
//  File.swift
//  CorrentLocation
//
//  Created by Admin on 10/10/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
extension UIButton
{
    func setRadius() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
    }
}
