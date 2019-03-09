//
//  MockServices.swift
//  Jenny Creig
//
//  Created by gourav sharma on 6/28/18.
//  Copyright © 2018 SharpMedical. All rights reserved.
//

import Foundation

struct MockService  {
    
  static func request< T: Codable>(fileName : String, completion: (APIResponse<T, APIError>) -> Void) {
        
        print("Loading Mock CarePlan Data")
        
        let resource = GenericResource(path: fileName, method: .GET, headers: nil, parameters: nil)
        
        if let url = Bundle.main.url(forResource: resource.path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                 completion(.success(value))
            } catch {
               completion(APIResponse.failure(.RequestFailed))
            }
        }
        return  completion(APIResponse.failure(.CouldNotDecodeJSON))
        
    }
    
}
