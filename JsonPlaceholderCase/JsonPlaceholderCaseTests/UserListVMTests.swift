import XCTest
import RxSwift
@testable import JsonPlaceholderCase

class UserListVMTests: XCTestCase {
    
    var viewModel: UserListVM!
    var mockService: MockBaseService!
    
    override func setUp() {
        super.setUp()
        mockService = MockBaseService()
        viewModel = .init(baseService: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccess() {
        let mockUsers = [
            User(
                id: 1,
                name: "John Doe",
                username: "johndoe",
                email: "johndoe@example.com",
                address: Address(street: "123 Main St", suite: "Apt 4", city: "New York", zipcode: "10001", geo: Geo(lat: "40.7128", lng: "74.0060")),
                phone: "123-456-7890",
                website: "http://johndoe.com",
                company: Company(name: "Doe Corp", catchPhrase: "Innovating the future", bs: "Tech")
            ),
            User(
                id: 2,
                name: "Jane Doe",
                username: "janedoe",
                email: "janedoe@example.com",
                address: Address(street: "456 Elm St", suite: "Apt 5", city: "Los Angeles", zipcode: "90001", geo: Geo(lat: "34.0522", lng: "118.2437")),
                phone: "987-654-3210",
                website: "http://janedoe.com",
                company: Company(name: "Doe Enterprises", catchPhrase: "Building a better tomorrow", bs: "Consulting")
            )
        ]
        mockService.mockResponse = mockUsers
        
        viewModel.fetchUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.users.value.count, 2)
            XCTAssertEqual(self.viewModel.users.value[0].name, "John Doe")
            XCTAssertEqual(self.viewModel.users.value[1].email, "janedoe@example.com")
        }
    }
    
    func testFetchUsersFailure() {
        let mockError = NSError(domain: "TestError", code: 123, userInfo: [NSLocalizedDescriptionKey: "An error occurred"])
        mockService.mockError = mockError
        
        viewModel.fetchUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.users.value.count, 0)
            XCTAssertFalse(self.viewModel.isLoaded.value)
        }
    }
}


class MockBaseService: BaseService {
    var mockResponse: [User]?
    var mockError: Error?
    
    func send<T>(_ request: T, onSuccess: @escaping (T.Response) -> Void, onError: @escaping (Error) -> Void) where T : BaseRequest {
        
        if let response = mockResponse {
            onSuccess(response as! T.Response)
        } else if let error = mockError {
            onError(error)
        }
    }
}
