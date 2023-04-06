
import UIKit

typealias GroceryTabs = (
    home: UIViewController,
    cart: UIViewController,
    profile: UIViewController
)

protocol TabBarView: AnyObject {
    func updateCartCount(count: Int)
}

class GroceryTabBarController: UITabBarController {
    
    var cartTab: UIViewController
    var presenter: TabBarPresentation
    
    init(tabs: GroceryTabs, presenter: TabBarPresenter) {
        self.presenter = presenter
        self.cartTab = tabs.cart
        super.init(nibName: nil, bundle: nil)
        viewControllers = [tabs.home, tabs.cart, tabs.profile]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
}

extension GroceryTabBarController: TabBarView {
    
    func updateCartCount(count: Int) {
        self.cartTab.tabBarItem.badgeValue = count > 0 ? String(describing: count) : nil
    }
    
}
