//
//  AddOrderViewController.swift
//  Coffee-Order
//
//  Created by Ashutosh Purushottam on 24/02/20.
//  Copyright © 2020 Ashutosh Purushottam. All rights reserved.
//

import UIKit

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    private var viewModel = AddOrderViewModel()
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        setUI()
    }
    
    private func setUI() {
        // set up segmented control
        coffeeSizesSegmentedControl = UISegmentedControl(items: viewModel.sizes)
        coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(coffeeSizesSegmentedControl)
        
        coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // select capuccinno as default
        let indexPath = NSIndexPath(item: 0, section: 0) as IndexPath
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: UITableView.ScrollPosition.middle)
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        
        // select medium as default size
        coffeeSizesSegmentedControl.selectedSegmentIndex = 1
    }
    
    @IBAction func save() {
        let name = nameTextField.text
        let email = emailTextField.text
        let selectedSize = coffeeSizesSegmentedControl.titleForSegment(at: coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("No coffee was selected")
        }
        let selectedType = viewModel.types[indexPath.row]
        
        
        if let name = name, let email = email, let selectedSize = selectedSize {
            print("name: \(name)")
            print("email: \(email)")
            print("selected size: \(String(describing: selectedSize))")
            print("selected type: \(selectedType)")
            
            if name.isEmpty || email.isEmpty {
                return
            }
            
            viewModel.name = name
            viewModel.email = email
            viewModel.selectedSize = selectedSize
            viewModel.selectedType = selectedType
            
            WebService().load(resource: Order.create(viewModel)) { result in
                
                switch(result) {
                case .success(let order):
                    print(order ?? "Nil order")
                case .failure(let error):
                    print(error)
                }
                
            }
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeCell", for: indexPath)
        cell.textLabel?.text = viewModel.types[indexPath.row].capitalized
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
}
