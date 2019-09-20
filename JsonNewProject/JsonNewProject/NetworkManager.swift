//
//  NetworkManager.swift
//  JsonNewProject
//
//  Created by MCS on 9/17/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation

/*class NetworkManager{
    
    static let shared = NetworkManager()
    
    private init(){ }
    //var dictionary: [String] = []
    func getDictionary(from url: String, completion: @escaping([NetworkManager]?, Error?) -> Void){
        guard let url = URL(string: url) else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            var dictionary: [NetworkManager] = []
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                for case let result in json ["results"] {
                    if let dict = NetworkManager(json: result){
                        dictionary.append(dict)
                    }
                }
            
                    
                }
            
            
           // completion(pokemon, nil)
           // self.Poke = pokemon.ability
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidURL
    case noPokemonData
}*/
