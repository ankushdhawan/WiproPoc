//
//  CountryDataSource.swift
//  POC
//
//  Created by Neeraj Mishra on 3/9/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit

class CountryDataSource: NSObject, UITableViewDataSource {
    
    var countryDtailModels = [CountryDetailModel]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countryDtailModels.count > 0 ? 1 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryDtailModels.count 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifier.kCountryCell, for: indexPath) as! CountryTableViewCell
        cell.selectionStyle = .none
        cell.configureView(model:countryDtailModels[indexPath.row])
        cell.awakeFromNib()
        return cell
    }
}
