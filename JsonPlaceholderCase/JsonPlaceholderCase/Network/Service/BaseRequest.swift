import Foundation

public protocol BaseRequest {
    associatedtype Response: Decodable
    
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var param: String? { get }
    
}

extension BaseRequest {
    var baseUrl: String { return "https://jsonplaceholder.typicode.com/" }
    
    var asURLRequest: URLRequest? {
        guard let url = URL(string: baseUrl + path + (param ?? "")) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
}

public enum HTTPMethod : String {
    case GET
    case POST
    case PUT
    case DELETE
}
