//
//  OrdersTableViewController.swift
//  HotCoffee
//
//  Created by Татьяна on 21.05.2022.
//

import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {

    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }

    
    private func populateOrders() {
        guard let coffeeOrdersUrl = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("URL is not correct")
        }
        
        let resource = Resource<[Order]>(url: coffeeOrdersUrl)
        Webservice().load(resource: resource) { [weak self] result in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController, let addCoffeeOrderVC = navC.viewControllers.first as? AddOrderViewController else {
            fatalError("Error performing segue")
        }
        addCoffeeOrderVC.delegate = self
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        return cell
    }
    
    //MARK: - Add Coffee Delegate functions
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
}
