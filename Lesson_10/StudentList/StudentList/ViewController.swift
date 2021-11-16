//
//  ViewController.swift
//  StudentList
//
//  Created by Nickolai Nikishin on 16.11.21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var dataSource = ["Aртимович Игорь Владимирович",
                      "Богданович Дмитрий Александрович",
                      "Букаренко Арина Олеговна",
                      "Гришин Павел Андреевич",
                      "Ефименко Анастасия Владимировна",
                      "Куклицкий Максим Сергеевич",
                      "Лапин Николай Владимирович",
                      "Малишевский Никита Валерьевич",
                      "Матвеенко Сергей Александрови",
                      "Мостовой Алексей Алексеевич",
                      "Пачковский Михаил Тадеушевич",
                      "Пернацкая Алеся Юрьевна",
                      "Савков Александр Геннадьевич",
                      "Сандова Галина Александровна",
                      "Симонов Владислав Дмитриевич",
                      "Сысов Валерий Александрович",
                      "Елисеева Марина Михайловна"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Список студентов"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentCell", for: indexPath) as! StudentCell
        
        cell.nameLabel.text = dataSource[indexPath.row]
        
        return cell
    }
}

