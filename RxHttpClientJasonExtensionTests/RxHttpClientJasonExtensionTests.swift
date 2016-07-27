import XCTest
import RxHttpClient
import RxHttpClientJasonExtension
import OHHTTPStubs
import RxSwift
import JASON

class RxHttpClientJasonExtensionTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testReturnCorrectJson() {
		stub({ $0.URL?.absoluteString == "https://test.com/json"	}) { _ in
			let jsonData = try! NSJSONSerialization.dataWithJSONObject(["Field1": "Data1", "Field2": "Data2"], options: .PrettyPrinted)
			return OHHTTPStubsResponse(data: jsonData, statusCode: 200, headers: nil)
		}
		
		let client = HttpClient()
		let url = NSURL(baseUrl: "https://test.com/json", parameters: nil)!
		let bag = DisposeBag()
		
		let expectation = expectationWithDescription("Should return correct JSON")
		client.loadJsonData(url).bindNext { json in
			XCTAssertEqual("Data1", json["Field1"].stringValue)
			XCTAssertEqual("Data2", json["Field2"].stringValue)
			expectation.fulfill()
		}.addDisposableTo(bag)
		
		waitForExpectationsWithTimeout(1, handler: nil)
	}
	
	func testNotReturnJsonIfNoDataProvided() {
		stub({ $0.URL?.absoluteString == "https://test.com/json"	}) { _ in
			return OHHTTPStubsResponse(data: NSData(), statusCode: 200, headers: nil)
		}
		
		let client = HttpClient()
		let url = NSURL(baseUrl: "https://test.com/json", parameters: nil)!
		let bag = DisposeBag()
		
		let expectation = expectationWithDescription("Should not return JSON")
		client.loadJsonData(url).doOnCompleted { expectation.fulfill() }.bindNext { _ in
			XCTFail("Should not return json data")
			}.addDisposableTo(bag)
		
		waitForExpectationsWithTimeout(1, handler: nil)
	}
	
	func testReturnError() {
		stub({ $0.URL?.absoluteString == "https://test.com/json"	}) { _ in
			return OHHTTPStubsResponse(error: NSError(domain: "TestDomain", code: 1, userInfo: nil))
		}
		
		let client = HttpClient()
		let url = NSURL(baseUrl: "https://test.com/json", parameters: nil)!
		let bag = DisposeBag()
		
		let expectation = expectationWithDescription("Should return correct JSON")
		client.loadJsonData(url).doOnError { error in
			let error = error as NSError
			XCTAssertEqual(error.code, 1)
			XCTAssertEqual(error.domain, "TestDomain")
			expectation.fulfill()
		}.subscribe().addDisposableTo(bag)
		
		waitForExpectationsWithTimeout(1, handler: nil)
	}
}
