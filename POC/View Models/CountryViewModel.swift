//
//  CountryViewModel.swift
//  POC
//
//  Created by Ankush on 3/8/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation

protocol GenericViewModel {
    
    //Handler
    var successViewClosure: (()->())? {get set}
    var showAlertClosure: ((String)->())? {get set}
    var alertMessage: String {get set}
}

class CountryViewModel : GenericViewModel{
    
    private let client = CountryDetailApiClient()
    // let validator = Validator()
    
    //Handler
    var successViewClosure: (()->())?
    var showAlertClosure: ((String)->())?
    
    internal var countryInfo : CountryModel? {
        didSet { self.successViewClosure?() }
    }
    
    //Private
    internal var alertMessage: String = "Error" {
        didSet{
            self.showAlertClosure!(alertMessage)
        }
    }
    
    func callWebServices(servicePath : JCPostServicePath) {
        showLoader()
        let resource = GenericResource(path: servicePath.path.rawValue, method:.GET)
        client.fetchCountryData(resource: resource) { (response) in
            hideLoader()
            if response.isSuccess {
                
                
                if let country = response.value {
                    self.countryInfo = country
                    
                    
                }
                
            } else {
                
                self.alertMessage = response.error.debugDescription
            }
            
        }
        
    }
}

