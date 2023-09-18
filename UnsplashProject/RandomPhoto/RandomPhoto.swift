//
//  RandomPhoto.swift
//  UnsplashProject
//
//  Created by 박소진 on 2023/09/18.
//

import Foundation

// MARK: - RandomPhoto
struct RandomPhoto: Codable, Hashable {
    let id: String
    let width, height: Int
    let altDescription: String
    let urls: Urls
    let links: RandomPhotoLinks
    let likes: Int
    let views, downloads: Int

    enum CodingKeys: String, CodingKey {
        case id
        case width, height
        case altDescription = "alt_description"
        case urls, links, likes
        case views, downloads
    }
}

// MARK: - Urls
struct Urls: Codable, Hashable {
    let raw, full, regular, small: String
    let thumb, smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw, full, regular, small, thumb
        case smallS3 = "small_s3"
    }
}

// MARK: - RandomPhotoLinks
struct RandomPhotoLinks: Codable, Hashable {
    let linksSelf, html, download, downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case html, download
        case downloadLocation = "download_location"
    }
}
