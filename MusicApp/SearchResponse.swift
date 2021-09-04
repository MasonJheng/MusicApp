//
//  SearchResponse.swift
//  MusicApp
//
//  Created by masonjheng on 2021/9/4.
//

import Foundation
struct SearchResponse: Codable {
   let resultCount: Int
   let results: [StoreItem]
}
struct StoreItem: Codable {
   let artistName: String
   let trackName: String
   let collectionName: String?
   let previewUrl: URL
   let artworkUrl100: URL
   let trackPrice: Double?
   let releaseDate: Date
   let isStreamable: Bool?
}

