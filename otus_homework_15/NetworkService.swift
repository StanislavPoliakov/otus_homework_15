//
//  NetworkService.swift
//  otus_homework_15
//
//  Created by Поляков Станислав Денисович on 23.07.2024.
//

import Foundation

protocol NetworkService {
    func loadImage(url: String): Data
}
