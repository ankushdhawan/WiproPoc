//
//  CountryModel.swift
//  POC
//
//  Created by Ankush on 3/8/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation
struct CountryModel: Codable {
    var title:String?
    var rows:[CountryDetailModel] = [CountryDetailModel]()
    
}
struct CountryDetailModel: Codable {
    var title:String?
    var description:String?
    var imageHref:String?
    
}

