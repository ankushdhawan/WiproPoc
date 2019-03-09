//
//  CountryDetailApiClient.swift
//  POC
//
//  Created by Neeraj Mishra on 3/8/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation

class CountryDetailApiClient: APIClient {
   
   
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience  init() {
        self.init(configuration: .default)
    }
    
    func fetchCountryData(resource : JCAPIResource,completion: @escaping (APIResponse<CountryModel, APIError>) -> Void) {
        
      

        fetch(with: resource , decode: { json -> CountryModel? in
            guard let user = json as? CountryModel else { return  nil }
            return user
        }, completion: completion)
    }
}
