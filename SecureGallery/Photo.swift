//
//  Photo.swift
//  SecureGallery
//
//  Created by Дмитрий  Ванчугов on 22.02.2022.
//

import Foundation

class Photo:Codable{
    var name: String
    var comment: String?
    var like: Bool = false
    
    init(name: String, comment: String?) {
        self.name = name
        self.comment = comment
     
    }
    public enum CodingKeys: String, CodingKey {
        case name, comment, like
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self , forKey: .name)
        self.comment = try container.decode(String?.self, forKey: .comment)
        self.like = try container.decode(Bool.self, forKey: .like)

    }
    
    public func encode(to encoder:Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.name , forKey: .name)
        try container.encode(self.comment , forKey: .comment)
        try container.encode(self.like , forKey: .like)
    }
    
    
}

extension UserDefaults {
    func set<T:Encodable>(encodable: T, for key: String){
        if let data = try? JSONEncoder().encode(encodable){
            set(data, forKey:  key)
        }
    }
    func value<T:Decodable>(_ type: T.Type , for key: String) ->T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data){
            return value
        }
        return nil
    }
    
    
}
