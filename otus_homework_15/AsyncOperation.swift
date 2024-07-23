//
//  AsyncOperation.swift
//  otus_homework_15
//
//  Created by Поляков Станислав Денисович on 23.07.2024.
//

import Foundation

class AsyncOperation : Operation {
    private let syncQueue = DispatchQueue(label: "sync-queue")
    
    override var isAsynchronous: Bool {
        return true
    }
    
    private var _isExecuting: Bool = false
    override var isExecuting: Bool {
        get {
            syncQueue.sync {
                return _isExecuting
            }
        }
        set {
            willChangeValue(forKey: "isExecuting")
            syncQueue.sync {
                _isExecuting = newValue
            }
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _isFinished: Bool = false
    override var isFinished: Bool {
        get {
            syncQueue.sync {
                return _isFinished
            }
        }
        set {
            willChangeValue(forKey: "isFinished")
            syncQueue.sync {
                _isFinished = newValue
            }
            didChangeValue(forKey: "isFinished")
        }
    }
    
    override func start() {
        guard !isCancelled else {
            finish()
            return
        }
        
        isFinished = false
        isExecuting = true
        main()
    }
    
    func finish() {
        isExecuting = false
        isFinished = true
    }
}
