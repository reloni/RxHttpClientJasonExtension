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

public extension HttpClientProtocol {
	public func loadJsonData(request: NSMutableURLRequestProtocol)
		-> Observable<Result<JSON>> {
			return Observable.create { observer in
				//guard let object = self else { observer.onCompleted(); return NopDisposable.instance }
				let task = self.loadData(request).bindNext { result in
					if case .successData(let data) = result {
						observer.onNext(Result.success(Box(value: JSON(arrayLiteral: data))))
					} else if case .error(let error) = result {
						observer.onNext(Result.error(error))
						observer.onCompleted()
					}
					
					observer.onCompleted()
				}
				
				return AnonymousDisposable {
					task.dispose()
				}
				}.shareReplay(0)
	}
}