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
			return loadData(request).flatMapLatest { data -> Observable<JSON> in
				return data.length == 0 ? Observable.empty() : Observable.just(JSON(data))
			}
	}
}