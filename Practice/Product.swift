//
//  Product.swift
//  Practice
//
//  Created by Admin on 17/10/24.
//

import Foundation
import UIKit

import Foundation
import UIKit

struct Product: Decodable {
    var title: String
    var imageURL: String // Store the URL as a String
    var description: String
    var price: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURL = "image" // Assuming the JSON has an "image" key
        case description
        case price
    }
}

