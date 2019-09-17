//
//  ViewController.swift
//  jsonProject
//
//  Created by MCS on 9/16/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // file denotions are in url
        guard let jsonURL = Bundle.main.url(forResource: "PokemonExample", withExtension: "json"), let data = try? Data(contentsOf: jsonURL), let pokemon = try? JSONDecoder().decode(Pokemon.self, from: data) /*, let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]*/ else {return}
        // (string: any) defines the string key with any type like arrays, dictionary, numbers or string
        
        //print(Pokemon(jsonDict: jsonDict))
        print(pokemon)
    }

}

struct Pokemon: Codable {
    let name: String
    let base_experience: Int
    // initialising means we are initialising all the properties with its values example pokemon will get its name property its values
    
    //? in init makes it a failable init .... return nil
   /* init?(jsonDict: [String: Any]) {
        guard let name = jsonDict["name"] as? String else {return nil}
        self.name = name
 */ //this is replaced by codable
 
    let abilities: [Ability]
    
    let sprites: Sprites
    
    let stats: [Stats]
    
}

struct Stats: Codable {
    let baseStat: Int
    let effort: Int
    let name: String
    
    enum statCodingKeys: String, CodingKey{
        case baseStat = "base_stat"
        case effort
        case stat
    }
    
    enum statContainerCodingKeys: String, CodingKey{
        case name
    }
    
    init(from decoder: Decoder) throws {
        let statContainer = try decoder.container(keyedBy: statCodingKeys.self)
        // for the nested distionary in the ability dictionary to get the name property
        let statNameContainer = try statContainer.nestedContainer(keyedBy: statContainerCodingKeys.self, forKey: .stat)
        baseStat = try statContainer.decode(Int.self, forKey: .baseStat)
        effort = try statContainer.decode(Int.self, forKey: .effort)
        name = try statNameContainer.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var statContainer = encoder.container(keyedBy: statCodingKeys.self)
        var statNameContainer = statContainer.nestedContainer(keyedBy: statContainerCodingKeys.self, forKey: .stat)
        try statNameContainer.encode(name, forKey: .name)
        try statContainer.encode(baseStat, forKey: .baseStat)
        try statContainer.encode(effort, forKey: .effort)
    }
    
}

struct Sprites: Codable {
    let B_Default: String
    let B_Female: String?
    let B_Shiny: String
    let B_ShinyFemale: String?
    let F_Default: String
    let F_Female: String?
    let F_Shiny: String
    let F_ShinyFemale: String?
    
    enum SpritesCodingKey: String, CodingKey {
        case B_Default = "back_default"
        case B_Female = "back_female"
        case B_Shiny = "back_shiny"
        case B_ShinyFemale = "back_shiny_female"
        case F_Default = "front_default"
        case F_Female = "front_female"
        case F_Shiny = "front_shiny"
        case F_ShinyFemale = "front_shiny_female"
    }
   
    init(from decoder: Decoder) throws {
        let spriteContainer = try decoder.container(keyedBy: SpritesCodingKey.self)
        B_ShinyFemale = try spriteContainer.decode(String?.self, forKey: .B_ShinyFemale)
        B_Default = try spriteContainer.decode(String.self, forKey: .B_Default)
        B_Shiny = try spriteContainer.decode(String.self, forKey: .B_Shiny)
        B_Female = try spriteContainer.decode(String?.self, forKey: .B_Female)
        F_ShinyFemale = try spriteContainer.decode(String?.self, forKey: .F_ShinyFemale)
        F_Default = try spriteContainer.decode(String.self, forKey: .F_Default)
        F_Shiny = try spriteContainer.decode(String.self, forKey: .F_Shiny)
        F_Female = try spriteContainer.decode(String?.self, forKey: .F_Female)
    }
    func encode(to encoder: Encoder) throws {
        var spriteContainer = encoder.container(keyedBy: SpritesCodingKey.self)
        
       try spriteContainer.encode(B_ShinyFemale, forKey: .B_ShinyFemale)
       try spriteContainer.encode(B_Default, forKey: .B_Default)
       try spriteContainer.encode(B_Shiny, forKey: .B_Shiny)
       try spriteContainer.encode(B_Female, forKey: .B_Female)
      try  spriteContainer.encode(F_ShinyFemale, forKey: .F_ShinyFemale)
      try  spriteContainer.encode(F_Default, forKey: .F_Default)
      try  spriteContainer.encode(F_Shiny, forKey: .F_Shiny)
      try  spriteContainer.encode(F_Female, forKey: .F_Female)
        
    }
}

struct Ability: Codable {
    let isHidden: Bool
    let slot: Int
    let name: String
    
    enum codingKeys: String, CodingKey{
        case isHidden = "is_hidden"
        case slot
        case ability
    }
    
    enum AbilityContainerCodingKeys: String, CodingKey{
        case name
    }
    
    // throws s a keyboard which means it can throw errors
    // when we have nested disctionary
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: codingKeys.self)
        // for the nested distionary in the ability dictionary to get the name property
        let abilityContainer = try container.nestedContainer(keyedBy: AbilityContainerCodingKeys.self, forKey: .ability)
        isHidden = try container.decode(Bool.self, forKey: .isHidden)
        slot = try container.decode(Int.self, forKey: .slot)
        name = try abilityContainer.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: codingKeys.self)
        var abilityContainer = container.nestedContainer(keyedBy: AbilityContainerCodingKeys.self, forKey: .ability)
        try abilityContainer.encode(name, forKey: .name)
        try container.encode(isHidden, forKey: .isHidden)
        try container.encode(slot, forKey: .slot)
    }
}
