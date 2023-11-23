//
//  TMDBService+DecodeHelpers.swift
//  TMDBApi
//
//  Created by 鍾秉辰 on 2023/11/21.
//

import Foundation

extension TMDBService {
    
    func decodeModel<T: Decodable>(_ jsonData: Data) throws -> T {
        do {
            let decodedObject = try JSONDecoder().decode(T.self, from: jsonData)
            return decodedObject
        } catch {
            throw ErrorEnvelope.couldNotDecodeJSON(error)
        }
    }
}
