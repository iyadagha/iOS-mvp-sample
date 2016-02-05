import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var emptyView: UIView?
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?

    private let userPresenter = UserPresenter(userService: UserService())
    private var usersToDisplay = [UserViewData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dataSource = self
        activityIndicator?.hidesWhenStopped = true

        userPresenter.attachView(self)
        userPresenter.getUsers()
    }

}

extension UserViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersToDisplay.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "UserCell")
        let userViewData = usersToDisplay[indexPath.row]
        cell.textLabel?.text = userViewData.name
        cell.detailTextLabel?.text = userViewData.age
        cell.textLabel
        return cell
    }

}

extension UserViewController: UserView {

    func startLoading() {
        activityIndicator?.startAnimating()
    }

    func finishLoading() {
        activityIndicator?.stopAnimating()
    }

    func setUsers(users: [UserViewData]) {
        usersToDisplay = users
        tableView?.hidden = false
        emptyView?.hidden = true;
        tableView?.reloadData()
    }

    func setEmptyUsers() {
        tableView?.hidden = true
        emptyView?.hidden = false;
    }


}

