import Foundation

typealias AllUserResponse = [User]

struct GetAllUserRequest: BaseRequest {
    typealias Response = AllUserResponse
    
    let path: String = "/users"
    let method: HTTPMethod = .GET
    let param: String?
    
    init() {
        self.param = ""
    }
}
