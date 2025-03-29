//
//  Publisher+Extension.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Combine

extension Publisher where Failure == NetworkError {
    
    func singleOutput(with cancellables: inout Set<AnyCancellable>) async -> Result<Output, NetworkError> {
        return await withCheckedContinuation { continuation in
            var didReceiveValue = false
            var cancellable: AnyCancellable?
            
            cancellable = sink(receiveCompletion: { receivedCompletion in
                switch receivedCompletion {
                case .finished:
                    break
                case .failure(let error):
                    continuation.resume(returning: .failure(error))
                }
            }, receiveValue: { value in
                guard !didReceiveValue else { return }
                didReceiveValue = true
                continuation.resume(returning: .success(value))
                cancellable?.cancel()
            })
            cancellable?.store(in: &cancellables)
        }
    }
}
