//
//  DownloadOperation.swift
//  otus_homework_15
//
//  Created by Поляков Станислав Денисович on 23.07.2024.
//

import Foundation

enum NetworkError : Error {
    case networkError
}

class DownloadOperation : AsyncOperation {
    let urlString: String
    let completion: (Result<Data, Error>) -> Void
    
    init(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        self.urlString = urlString
        self.completion = completion
    }
    
    override func main() {
        guard let url = URL(string: urlString) else {
            finish()
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard
                error == nil,
                let code = (response as? HTTPURLResponse)?.statusCode,
                200..<300 ~= code,
                let imageData = data
            else {
                self?.completion(.failure(NetworkError.networkError))
                self?.finish()
                return
            }
            
            self?.completion(.success(imageData))
            self?.finish()
        }.resume()
    }
}
