import UIKit

class UserDetailVC: UIViewController {

    var userModel: User?
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var websiteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = userModel?.name
        emailLabel.text = userModel?.email
        phoneLabel.text = userModel?.phone
        websiteLabel.text = userModel?.website
    }
}
