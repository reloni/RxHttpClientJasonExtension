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
	/**
	Loads data and convert to JSON
	- parameter url: URL for HTTP request
	- returns: Created observable sequence that emits JSON
	*/
	func loadJsonData(url: NSURL) -> Observable<JSON> {
		return loadJsonData(createUrlRequest(url))
	}
	
	/**
	Loads data and convert to JSON
	- parameter url: URL request
	- returns: Created observable sequence that emits JSON
	*/
	func loadJsonData(request: NSURLRequest) -> Observable<JSON> {
			return loadData(request).flatMapLatest { result -> Observable<JSON> in
				switch result {
				case .successData(let data): return Observable.just(JSON(data))
				case .error(let error): return Observable.error(error)
				default: return Observable.empty()
				}
			}
	}
}