//
//  Youtube.swift
//  ImdbApp
//
//  Created by Ivan Lyaskovets on 07.10.2022.
//

import Foundation

struct YoutubeResponse: Codable{
    let items: [YoutubeElement]
}

struct YoutubeElement: Codable{
    let id: YoutubeVideo
}

struct YoutubeVideo: Codable{
    let videoId: String
}
