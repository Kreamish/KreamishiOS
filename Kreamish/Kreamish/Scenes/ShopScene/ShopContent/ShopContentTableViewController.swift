import UIKit

class ShopContentTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        tableView.register(ShopContentTableViewCell.self, forCellReuseIdentifier: ShopContentTableViewCell.id)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Return the number of rows you want to display
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 4000  // Set the desired height for your cells
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ShopContentTableViewCell.id, for: indexPath) as? ShopContentTableViewCell {
            cell.layoutIfNeeded()
            
            let productViewController = ProductCollectionViewController()
            self.addChild(productViewController)
            cell.addSubview(productViewController.view)
            
            productViewController.didMove(toParent: self)
            productViewController.view.layoutIfNeeded()
            
            return cell
        } else {
            fatalError("DequeueReusableCell failed while casting")
        }
    }
}

