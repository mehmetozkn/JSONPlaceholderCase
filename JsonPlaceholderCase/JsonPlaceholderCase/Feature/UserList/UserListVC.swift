import UIKit
import RxSwift
import RxCocoa

class UserListVC: UIViewController {
    private let viewModel = UserListVM()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        bind()
        viewModel.fetchUsers()
    }
    
    private func bindTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: UserListTableViewCell.self), bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
        
        viewModel.users
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in self?.tableView.reloadData() })
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bind() {
        viewModel.isLoaded
            .observeOn(MainScheduler.instance)
            .bind { [weak self] isLoaded in
                // Until the data is loaded
                self?.activityIndicator.isHidden = isLoaded
                self?.tableView.isHidden = !isLoaded
            }
            .disposed(by: viewModel.disposeBag)
    }
}


extension UserListVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        let name = viewModel.users.value[indexPath.row].name
        let email = viewModel.users.value[indexPath.row].email
        cell.nameLabel.text = name
        cell.emailLabel.text = email
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.value.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = viewModel.users.value[indexPath.row]
        navigateToViewController(viewControllerType: UserDetailVC.self, nibName: "UserDetailVC", model: selectedModel) { (viewController, model) in
            if let userDetailVC = viewController as? UserDetailVC, let userModel = model as? User {
                userDetailVC.userModel = userModel
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


