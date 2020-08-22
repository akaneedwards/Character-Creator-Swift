//
//  NetworkManager.swift
//  CharacterCreator
//
//  Created by Ethan Siapno on 12/7/19.
//  Copyright © 2019 Ethan CS 1998. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    private static let endpoint = "http://0.0.0.0:5000/characters/" // USE THE IP ADDRESS PLUS URL. HELPPPPP
    private static let postEndpoint = "http://0.0.0.0:5000/character/" // LMAOFODJSFOISOGOISDIOIOFAJF
    private static let deleteEndpoint = "http://0.0.0.0:5000/character/" // REMEMBER TO CHANGE
    
    static func getCharacters(completion: @escaping ([Character]) -> Void) {
        Alamofire.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let charactersData = try? jsonDecoder.decode(CharacterResponse.self, from: data) {
                    let characters = charactersData.data
                    completion(characters)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func postCharacter(character: Character) {
        let param: [String: Any] = [
            "backHairImageName": character.backHairImageName,
            "frontHairImageName": character.frontHairImageName,
            "eyeImageName": character.eyeImageName,
            "eyebrowImageName": character.eyebrowImageName,
            "mouthImageName": character.mouthImageName,
            "skinColorImageName": character.skinColorImageName,
            "outfitImageName": character.outfitImageName,
            "shoeImageName": character.shoeImageName,
            "earImageName": character.earImageName
        ]
        Alamofire.request(postEndpoint, method: .post, parameters: param, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                
                if let charData = try? jsonDecoder.decode(Character.self, from: data) {
                    let indentifier = charData.id
                }
                print("SUCCESS!!")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    static func deleteCharacter(character: Character, ID: Int) {
        Alamofire.request(deleteEndpoint + "\(ID)", method: .delete).validate().responseData { response in
            switch response.result {
            case .success(_):
                print("Character deleted!")
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
