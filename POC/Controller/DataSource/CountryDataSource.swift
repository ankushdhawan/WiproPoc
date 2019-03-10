//
//  CountryDataSource.swift
//  POC
//
//  Created by Neeraj Mishra on 3/9/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit



class CountryDataSource: NSObject, UICollectionViewDataSource{
    var countryDtailModels = [CountryDetailModel]()

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryDtailModels.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Indentifier.kCountryCell, for: indexPath) as! CountryCell
        cell.configureView(model:countryDtailModels[indexPath.row])
        cell.awakeFromNib()
        return cell
    }
    
    
}
