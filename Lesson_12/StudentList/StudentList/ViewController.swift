//
//  ViewController.swift
//  StudentList
//
//  Created by Марина Елисеева on 16.11.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var women = ["Букаренко Арина Олеговна",
                 "Ефименко Анастасия Владимировна",
                 "Пернацкая Алеся Юрьевна",
                 "Сандова Галина Александровна",
                 "Елисеева Марина Михайловна"
    ].sorted()
    
    var men =  ["Богданович Дмитрий Александрович",
                "Гришин Павел Андреевич",
                "Куклицкий Максим Сергеевич",
                "Лапин Николай Владимирович",
                "Малишевский Никита Валерьевич",
                "Матвеенко Сергей Александрови",
                "Мостовой Алексей Алексеевич",
                "Пачковский Михаил Тадеушевич",
                "Савков Александр Геннадьевич",
                "Симонов Владислав Дмитриевич",
                "Сысов Валерий Александрович",
                "Артимович Игорь Владимирович"
    ].sorted()
    
    var filteredMen: [String] = []
    var filteredWomen: [String] = []
    
    var dataSource: [[String]] {
        [filteredMen, filteredWomen]
    }
    
    var filterText: String? {
        didSet {
            if let filterText = filterText {
                filterDataSource(filterText)
            } else {
                resetDataSource()
            }
        }
    }
    
    // MARK: - UIViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.keyboardDismissMode = .onDrag
        resetDataSource()
    }
    
    // MARK: - Functions
    
    func resetDataSource() {
        filteredMen = men
        filteredWomen = women
        tableView.reloadData()
    }
    
    func filterDataSource(_ filterText: String) {
        if filterText.count > 0 {
            filteredMen = men.filter {
                $0.lowercased().contains(filterText.lowercased())
            }
            
            filteredWomen = women.filter {
                $0.lowercased().contains(filterText.lowercased())
            }
            
            tableView.reloadData()
        } else {
            resetDataSource()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String = ""
        switch section {
        case 0: sectionName = "Мужчины"
        case 1: sectionName = "Женщины"
        default: break
        }
        return "\(sectionName) \(dataSource[section].count) человек"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        cell.nameLabel.text = dataSource[indexPath.section][indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        print("selected \(dataSource[indexPath.section][indexPath.row])")
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterText = searchText
    }
}
