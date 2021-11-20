//
//  ManualLayoutTableViewController.swift
//  StudentList
//
//  Created by Nickolai Nikishin on 20.11.21.
//

import UIKit

class ManualLayoutTableViewController: UIViewController {

    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.backgroundColor = .red
        
        setupTableView()
    }
    
    func setupTableView() {
        
    }
}
