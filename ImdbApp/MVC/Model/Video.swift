//
//  Video.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 04.10.2022.
//

import Foundation

struct CategoryResponse: Codable{
    let items: [Video]
}

struct Video: Codable{
    let title: String
    let year: String
    let image: String
}
