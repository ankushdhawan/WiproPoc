//
//  Constants.swift
//  JennyCraig
//
//  Created by gourav sharma on 6/21/18.
//  Copyright © 2018 JennyCraig. All rights reserved.
//

import Foundation


import UIKit



struct Constants {

static var isIpad:Bool {
    
    return UIDevice.current.userInterfaceIdiom == .pad
    
    }
static let kScreenWidth = UIScreen.main.bounds.width
static let kScreenHeight = UIScreen.main.bounds.width
static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
}
struct ScreenTitle
{
        static let kTitleSettings = "Settings"
        static let kTitleLogin = "Login"

        static let kTitleReader = "GO NFC READER"

    }






    

