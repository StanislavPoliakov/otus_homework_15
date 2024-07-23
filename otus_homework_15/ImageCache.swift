//
//  ImageCache.swift
//  otus_homework_15
//
//  Created by Поляков Станислав Денисович on 23.07.2024.
//

import Foundation

protocol ImageCache {
    func get(key: String) -> Data?
    func put(key: String, data: Data)
}

class ImageCacheImpl : ImageCache {
    static let cache = ImageCacheImpl()
    
    private init() {}
    
    private var cacheMap: [String: Data] = [:]
    private let syncQueue = DispatchQueue(label: "cacheSyncQueue")
        
    func get(key: String) -> Data? {
        syncQueue.sync {
            return cacheMap[key]
        }
    }
    
    func put(key: String, data: Data) {
        syncQueue.sync {
            cacheMap[key] = data
        }
    }
}
