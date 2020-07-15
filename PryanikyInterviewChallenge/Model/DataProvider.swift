//
//  DataProvider.swift
//  PryanikyInterviewChallenge
//
//  Created by Zulfkhar Maukey on 15/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

protocol DataProviderDelegate {
    func get(data: Model)
}

class DataProvider {
    var delegate: DataProviderDelegate?
    let urlString = "https://pryaniky.com/static/json/sample.json"
    
    func fetchData() {
        guard let url = URL(string: urlString) else {return}
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard error == nil else {
                print("Error accessing session, \(error!.localizedDescription)")
                return
            }
            guard let safeData = data else {return}
            
            do {
                let results = try JSONDecoder().decode(Model.self, from: safeData)
                self?.delegate?.get(data: results)
            } catch {
                print("Error decoding jSON, \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
