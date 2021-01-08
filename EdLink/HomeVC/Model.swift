//
//  Model.swift
//  EdLink
//
//  Created by Muhammad Faruuq Qayyum on 08/01/21.
//

import UIKit

struct Model: Decodable, Hashable {
    let results: [Results]
    
    struct Results: Decodable, Hashable {
        let original_title: String
        let overview: String
        let poster_path: String
    }
}
