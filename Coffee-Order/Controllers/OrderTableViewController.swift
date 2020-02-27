//
//  OrderTableViewController.swift
//  Coffee-Order
//
//  Created by Ashutosh Purushottam on 24/02/20.
//  Copyright © 2020 Ashutosh Purushottam. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        populateOrder()
    }
    
    private func populateOrder() {        
        WebService().load(resource: Order.all) { result in
            switch result {
            case .success(let orders):
                print("Orders: \(orders)")
                self.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return orderListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath)
        
        let viewModel = orderListViewModel.orderViewModel(at: indexPath.row)
        
        cell.textLabel?.text = viewModel.type
        cell.detailTextLabel?.text = viewModel.size
        
        return cell
    }
    
    
    
}
