

import Foundation
import Alamofire


protocol APIClient {
    
    var session: URLSession { get }
    func fetch<T: Codable>(with request: JCAPIResource, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void)
}

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Codable?, APIError?) -> Void
    
    private func decodingTask<T: Codable>(with requestEnvelop: JCAPIResource, decodingType: T.Type, completionHandler completion: @escaping JSONTaskCompletionHandler)  {
        let method = requestEnvelop.method.rawValue
        let type = HTTPMethod(rawValue: method)
        let header = HTTPHeaders(requestEnvelop.headers!)
       
        let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/fact")
        

        AF.request(url!, method:type!, parameters:requestEnvelop.parameters, encoding:requestEnvelop.encoding.getEncodingType(), headers: header).response { (response) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    do {
                        let strJson = String(decoding: response.result.value!!, as: UTF8.self)
                        guard let data = strJson.data(using: .utf8, allowLossyConversion: false) else { return  }

                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                        print(json)
                        let genericModel = try JSONDecoder().decode(decodingType, from:data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .CouldNotDecodeJSON)
                    }
                }
                    
                    
                else
                {
                    completion(nil, .InvalidData)
                    
                }
                break
                
            case .failure(let errorObj):
                print(errorObj.localizedDescription)
                completion(nil, .ResponseUnsuccessful)
                
                break
                
            }
        }
        

       
    
    }
    
    
    func fetch<T: Codable>(with request: JCAPIResource, decode: @escaping (Codable) -> T?, completion: @escaping (APIResponse<T, APIError>) -> Void) {
        
      decodingTask(with: request, decodingType: T.self) { (json , error) in
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(APIResponse.failure(error))
                    } else {
                        completion(APIResponse.failure(.InvalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(APIResponse.failure(.CouldNotDecodeJSON))
                }
            }
            
        }
    }
    
    
    
    
    func mockRequest< T: Codable>(fileName : String, completion: (APIResponse<T, APIError>) -> Void) {
        
        
        let resource = GenericResource(path: fileName, method: .GET, headers: nil, parameters: nil)
        
        if let url = Bundle.main.url(forResource: resource.path, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                // decoder.keyDecodingStrategy = .convertFromSnakeCase
                let value = try decoder.decode(T.self, from: data)
                completion(.success(value))
            } catch {
                completion(APIResponse.failure(.RequestFailed))
            }
        }
        return  completion(APIResponse.failure(.CouldNotDecodeJSON))
        
    }
}

