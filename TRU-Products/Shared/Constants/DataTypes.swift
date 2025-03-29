//
//  DataTypes.swift
//  TRU-Products
//
//  Created by Ahmed Taha on 29/03/2025.
//

import Foundation
import Combine

typealias ResponsePublisher<M: Codable> = AnyPublisher<M, NetworkError>
typealias ModelResult<M> = Result<M, NetworkError>
typealias Cancellable = Set<AnyCancellable>
