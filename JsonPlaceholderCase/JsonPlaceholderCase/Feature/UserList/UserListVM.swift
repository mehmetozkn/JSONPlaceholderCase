import Foundation
import RxSwift
import RxCocoa

class UserListVM {
    let disposeBag = DisposeBag()
    let users = BehaviorRelay<[User]>(value: [])
    let isLoaded = BehaviorRelay<Bool>(value: false)
    private let baseService: BaseServiceProtocol

    init(baseService: BaseServiceProtocol = BaseService.shared) {
        self.baseService = baseService
    }
    
    func fetchUsers() {
        isLoaded.accept(false)
        let request = GetAllUserRequest()
        
        baseService.send(request, onSuccess: { [weak self] (response: [User]) in
            self?.users.accept(response)
            self?.isLoaded.accept(true)
        }, onError: { error in
            print("Error fetching users: \(error.localizedDescription)")
            self.isLoaded.accept(false)
        })
    }
}

