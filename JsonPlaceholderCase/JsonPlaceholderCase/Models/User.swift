import Foundation

// MARK: - User
struct User: Codable, Equatable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.username == rhs.username &&
            lhs.email == rhs.email &&
            lhs.address == rhs.address &&
            lhs.phone == rhs.phone &&
            lhs.website == rhs.website &&
            lhs.company == rhs.company
    }
}

// MARK: - Address
struct Address: Codable, Equatable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
    
    static func == (lhs: Address, rhs: Address) -> Bool {
        return lhs.street == rhs.street &&
            lhs.suite == rhs.suite &&
            lhs.city == rhs.city &&
            lhs.zipcode == rhs.zipcode &&
            lhs.geo == rhs.geo
    }
}

// MARK: - Geo
struct Geo: Codable, Equatable {
    let lat: String
    let lng: String
    
    static func == (lhs: Geo, rhs: Geo) -> Bool {
        return lhs.lat == rhs.lat && lhs.lng == rhs.lng
    }
}

// MARK: - Company
struct Company: Codable, Equatable {
    let name: String
    let catchPhrase: String
    let bs: String
    
    static func == (lhs: Company, rhs: Company) -> Bool {
        return lhs.name == rhs.name &&
            lhs.catchPhrase == rhs.catchPhrase &&
            lhs.bs == rhs.bs
    }
}
