//
//  Model.swift
//  PryanikyInterviewChallenge
//
//  Created by Zulfkhar Maukey on 15/7/2020.
//  Copyright © 2020 Zulfkhar Maukey. All rights reserved.
//

import Foundation

struct Model: Decodable {
    let data: [Data]
    let view: [String]
}

struct Data: Decodable {
    let name: String
    let data: InternalData
}

struct InternalData: Decodable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Option]?
}

struct Option: Decodable {
    let id: Int
    let text: String
}
