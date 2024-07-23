//
//  ImageLoader.swift
//  otus_homework_15
//
//  Created by Поляков Станислав Денисович on 23.07.2024.
//

import Foundation

protocol ImageLoader {
    func loadImage(url string: String, index: Int, completion: @escaping (Result<Data, Error>) -> Void)
}

class ImageLoaderImpl : ImageLoader {
    private let urlSession = URLSession.shared
    private var operationQueue: OperationQueue = {
        let oq = OperationQueue()
        oq.maxConcurrentOperationCount = 2
        return oq
    }()
    
    func loadImage(url string: String, index: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        let cache = ImageCacheImpl.cache
        
        if let imageData = cache.get(key: string) {
            print("[\(index)] - image from cache")
            completion(.success(imageData))
        } else {
            print("[\(index)] - downloading image...")
            let operation = DownloadOperation(urlString: string) { result in
                switch result {
                    case let .success(data): 
                        completion(.success(data))
                        cache.put(key: string, data: data)
                    case let .failure(error):
                        print(error)
                        completion(.failure(error))
                }
            }
            operationQueue.addOperation(operation)
        }
    }
}
