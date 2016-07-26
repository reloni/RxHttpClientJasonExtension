//
//  HttpClientExtension.swift
//  RxHttpClientJasonExtension
//
//  Created by Anton Efimenko on 04.07.16.
//  Copyright © 2016 Anton Efimenko. All rights reserved.
//

import Foundation
import RxHttpClient
import RxSwift
import JASON

public extension HttpClientType {
	public func loadJsonData(request: NSURLRequestType)
		-> Observable<JSON> {
			
			return loadData(request).flatMapLatest { result -> Observable<JSON> in
				switch result {
				case .successData(let data): return Observable.just(JSON(data))
				case .error(let error): return Observable.error(error)
				default: return Observable.empty()
				}
			}
	}
}