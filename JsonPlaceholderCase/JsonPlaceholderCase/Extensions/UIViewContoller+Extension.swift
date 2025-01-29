import Foundation
import UIKit

extension UIViewController {
    func navigateToViewController<T: UIViewController, M>(viewControllerType: T.Type, nibName: String, model: M, configure: (T, M) -> Void) {
        let viewController = T(nibName: nibName, bundle: nil)
        configure(viewController, model)
        navigationController?.pushViewController(viewController, animated: true)
    }
}



