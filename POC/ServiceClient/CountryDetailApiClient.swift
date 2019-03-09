//
//  CountryDetailApiClient.swift
//  POC
//
//  Created by Neeraj Mishra on 3/8/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import Foundation

class CountryDetailApiClient  {
   
   
    
    var client:APIClient
    init(client: APIClient) {
        self.client = client
    }
    
    convenience  init() {
        self.init(client: APIService())
    }
    
    func fetchCountryData(resource : JCAPIResource,completion: @escaping (APIResponse<CountryModel, APIError>) -> Void) {
        
      

        client.fetch(with: resource , decode: { json -> CountryModel? in
            guard let user = json as? CountryModel else { return  nil }
            return user
        }, completion: completion)
    }
}
