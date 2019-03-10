//
//  RootNavVC.swift
//  POC
//
//  Created by Ankush on 3/7/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit

class RootNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
       customInit()
        
        // Do any additional setup after loading the view.
    }
    //Mark:PRIVATE METHOD(S)
   private func customInit()
    {
        self.title = "CountryDetail"
        //self.navigationBar.barTintColor = ColorManager.NavBarColor
        UINavigationBar.appearance().backgroundColor = UIColor.blue
        let rootVC = CountryVC()
        rootVC.view.backgroundColor = UIColor.red
        
        self.viewControllers = [rootVC]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
