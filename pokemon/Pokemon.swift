//
//  Pokemon.swift
//  pokemon
//
//  Created by Neven on 06/08/2017.
//  Copyright © 2017 Neven. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _dex: Int!
    private var _describe: String!
    private var _defense: Double!
    private var _type: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: Double!
    private var _evoLevel: Int!
    private var _evoId: String!
    private var _evoName: String!
    
    var pokemonUrl: String!
    
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    var describe: String {
        if _describe == nil {
            return ""
        }
        return _describe
    }
    
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    
    var dex: Int {
        if _dex == nil {
            return 0
        }
        return _dex
    }
    
    var defense: Double {
        if _defense == nil {
            return 0
        }
        return _defense
    }
    
    var attack: Double {
        if _attack == nil {
            return 0
        }
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            return ""
        }
        return _height
    }
    
    var evoLevel: Int {
        if _evoLevel == nil {
            return 0
        }
        return _evoLevel
    }
    
    var evoId: String {
        if _evoId == nil {
            return "0"
        }
        return _evoId
    }
    
    var evoName: String {
        if _evoName == nil {
            return ""
        }
        return _evoName
    }
    
    
    init(name: String, dex: Int) {
        _name = name
        _dex = dex
        pokemonUrl = "\(base_url)\(pokemon_url)\(dex)"
    }
    
    func downloadJson(completed: @escaping downlaodCompleted) {
        
        Alamofire.request(pokemonUrl).responseJSON { (response) in
            if let dict = response.result.value as? [String: AnyObject] {
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                if let height = dict["height"] as? String {
                    self._height = height
                }
                if let defense = dict["defense"] as? Double {
                    self._defense = defense
                }
                if let attack = dict["attack"] as? Double {
                    self._attack = attack
                }
                if let types = dict["types"] as? [[String: AnyObject]]? {
                    for type in types! {
                        if let name = type["name"] as? String {
                            if self.type == "" {
                                self._type = name.capitalized
                            } else {
                                self._type = self._type + "/\(name.capitalized)"
                            }
                        }
                    }
                }
                
                if let descriptions = dict["descriptions"] as? [[String: AnyObject]], descriptions.count > 0 {
                    if let uri = descriptions[0]["resource_uri"] as? String {
                        let apiuri = "\(base_url)\(uri)"
                        Alamofire.request(apiuri).responseJSON(completionHandler: { (response) in
                            if let result = response.result.value as? [String: AnyObject],
                               let description = result["description"] as? String {
                                self._describe = description
                            }
                            completed()
                        })
                    }
                }
                
                if let evos = dict["evolutions"] as? [[String: AnyObject]], evos.count > 0 {
                    if let detail = evos[0]["detail"] as? String, detail == "mega" {
                        self._evoLevel = 0
                        self._evoName = ""
                        self._evoId = "0"
                    } else {
                        if let evoLevel = evos[0]["level"] as? Int {
                            self._evoLevel = evoLevel
                        }
                        if let evoName = evos[0]["to"] as? String {
                            self._evoName = evoName
                        }
                        
                        if let uri = evos[0]["resource_uri"] as? String {
                            let uriArray = uri.components(separatedBy: "/")
                            self._evoId = uriArray[4]
                        }
                    }
                }
            }
            completed()
        }
    }
    
    
    
}
