//
//  Network.swift
//  Nerkh
//
//  Created by Sina khanjani on 1/9/1399 AP.
//  Copyright © 1399 Sina Khanjani. All rights reserved.
//

import UIKit

public class Network<V:Codable, Element:Codable>: Disposable {
    
    public typealias NetworkResult = (NetworkResponse<V>) -> Void
    public typealias HashDictionary = [String:String]

    private(set) var baseURL: URL? = URL(string: UserDefaults.standard.value(forKey: "_baseURL") as! String)
    private var header : HashDictionary = [:]
    private var urlSession = URLSession.shared
    private var photo: (key: String, value: Data)?
    
    public var url: URL?
    public var method : Method = .get
    public var ignoreAuth = false
    public var parameters : HashDictionary?
    public var model : Element?
    public var bodyType: BodyType = .jsonBody
    
    public init(path:String, ignoreAuth:Bool = true) {
        self.url = baseURL?.appendingPathComponent(path)
        self.ignoreAuth = ignoreAuth
    }
    
    override public func dispose() {
        urlSession.invalidateAndCancel()
    }

    public func withPost() -> Network {
        method = Method.post
        return self
    }
    
    public func withGet() -> Network {
        method = Method.get
        return self
    }
    
    public func type(_ body: BodyType) {
        self.bodyType = body
    }
    
    public func add(_ key: String,_ value: String) -> Network {
        if (parameters == nil) { parameters = HashDictionary() }
        parameters?[key] = value
        return self
    }
    
    public func addAll(_ parameters : HashDictionary) -> Network {
        self.parameters = parameters
        return self
    }
    
    public func append(_ parameters : HashDictionary?) -> Network {
        guard let parameters = parameters else {
            return self
        }
        for i in parameters {
            self.parameters?[i.key] = i.value
        }
        return self
    }
    
    public func addObject(_ model: Element) -> Network {
        self.model = model
        return self
    }
    
    public func addPhoto(_ photoKey: String,_ data: Data) -> Network {
        self.photo = (key: photoKey, value: data)
        return self
    }
}

extension Network {
    public func post(completion: @escaping NetworkResult) -> Disposable {
        return request(method: .post, completion: completion)
    }
    
    public func get(completion: @escaping NetworkResult) -> Disposable {
        return request(method: .get, completion: completion)
    }
    
    public func attack(completion:  @escaping NetworkResult) -> Disposable {
        return request(method: method, completion: completion)
    }
}

extension Network {
    /// Network send your request to http/https server.
    private func request(method: Method, completion: @escaping NetworkResult) -> Disposable {
        guard let _ = baseURL else { completion(.error(NetworkErrors.BadURL)) ; return self }
        self.method = method
        header["Accept"] = "application/json"
        header.updateValue("application/json", forKey: "Content-Type")
        if let token = Authentication.default.token , !ignoreAuth {
            header["Authorization"] =  String(token)
        }
        // ==== Send Request ====
        switch bodyType {
        case .jsonBody:
            return jsonBodyRequest { (response) in
                completion(response)
            }
        case .formdata:
            guard method == .post else { completion(.error(NetworkErrors.BadRequest)) ; return self }
            return formdataRequest { (response) in
                completion(response)
            }
        }
    }
    
    private func jsonBodyRequest(completion: @escaping NetworkResult) -> Disposable {
        guard var url = url else { completion(.error(NetworkErrors.BadURL)) ; return self }
        if let parameters = parameters {
            url = url.withQuries(parameters)!
            self.parameters = nil
        }
        print("URL: \(url.absoluteURL)")
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        if method == .post && model != nil {
            if let model = model {
                let jsonEncoder = JSONEncoder()
                if let jsonData = try? jsonEncoder.encode(model) {
                    request.httpBody = jsonData
                }
            }
        }
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.error(NetworkErrors.NotFound))
                return
            }
            guard let data = data else { completion(.error(NetworkErrors.BadURL)) ; return }
            let jsonDecoder = JSONDecoder()
            guard let decodeJson = try? jsonDecoder.decode(V.self, from: data) else { completion(.error(NetworkErrors.json)) ; return }
            completion(.success(decodeJson))
        }
        task.resume()
        return self
    }
    
    private func formdataRequest(completion: @escaping NetworkResult) -> Disposable {
        guard let url = url else { completion(.error(NetworkErrors.BadURL)) ; return self }
        guard let parameters = parameters else { completion(.error(NetworkErrors.BadParameters)) ; return self }
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        let boundary = generateBoundary()
        request.allHTTPHeaderFields = header
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(withParameters: parameters, media: photo?.value, boundary: boundary, photoKey: photo?.key)
        request.httpBody = dataBody
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error as Any)
                completion(.error(NetworkErrors.NotFound))
                return
            }
            guard let data = data else { completion(.error(NetworkErrors.BadURL)) ; return }
            let jsonDecoder = JSONDecoder()
            guard let decodeJson = try? jsonDecoder.decode(V.self, from: data) else { completion(.error(NetworkErrors.json)) ; return }
            completion(.success(decodeJson))
        }
        task.resume()
        return self
    }
    
    private func generateBoundary() -> String {
         return "Boundary-\(NSUUID().uuidString)"
     }
     
     private func createDataBody(withParameters parameters: [String: String]?, media: Data?, boundary: String, photoKey: String?) -> Data {
         let lineBreak = "\r\n"
         var body = Data()
         if let parameters = parameters {
             for (key,value) in parameters {
                 body.append("--\(boundary + lineBreak)")
                 body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                 body.append("\(value + lineBreak)")
             }
         }
         if let media = media, let photoKey = photoKey {
             body.append("--\(boundary + lineBreak)")
             body.append("Content-Disposition: form-data; name=\"\(photoKey)\"; filename=\"\("\(arc4random())" + ".jpeg")\"\(lineBreak)")
             body.append("Content-Type: \(".jpeg" + lineBreak + lineBreak)")
             body.append(media)
             body.append(lineBreak)
         }
         body.append("--\(boundary)--\(lineBreak)")
         
         return body
     }
}

public enum BodyType {
    case formdata,jsonBody
}

public enum Method: String {
    case post = "POST"
    case get = "GET"
}
