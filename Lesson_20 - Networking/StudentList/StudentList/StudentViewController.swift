//
//  StudentViewController.swift
//  StudentList
//
//  Created by Марина Елисеева on 16.11.21.
//

import UIKit

struct NotificationObject {
    let student: String
    let gender: Int
    let sender: UIViewController
    
    init(student: String, gender: Int, sender: UIViewController) {
        self.student = student
        self.gender = gender
        self.sender = sender
    }
}

protocol StudentViewControllerDelegate: AnyObject {
    func didSelectStudent(_ student: String, gender: Int, sender: UIViewController)
}

class StudentViewController: UIViewController {
    
    var studentManager: StudentManagerProtocol!
    
    private lazy var tableView = UITableView()
    private lazy var selectButton = UIButton(type: .custom)
    private lazy var searchBar = UISearchBar()
    
    var shouldAddSelectButton = false
    var shouldAddSearchBar = false

    weak var delegate: StudentViewControllerDelegate?
    var didSelectStudentClosure: ((String, Int, UIViewController) -> ())?
    
    var men: [StudentObject] = DataSource.menArray
    
    private var filteredMen: [String] = []
    private var filteredWomen: [String] = []
    
    private var dataSource: [[StudentObject]] {
        [men]
    }
    
    private var filterText: String? {
        didSet {
           reloadFilterData()
        }
    }
    
    // MARK: - UIViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        reloadFilterData()
        
        if shouldAddSelectButton {
            NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "DidSelectStudentNotification"), object: nil, queue: nil) { [weak self] notification in
                if let object = notification.object as? NotificationObject {
                    self?.didSelectStudent(object.student, gender: object.gender, sender: object.sender)
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationTriggered), name: UIApplication.willResignActiveNotification, object: nil)
    }
    
    @objc func notificationTriggered() {
        print("notificationTriggered")
    }
    
    // MARK: - Functions
    
    private func saveData() {
//        studentManager.saveData(menList: men, womenList: women)
    }
    
    private func setup() {
        if shouldAddSearchBar {
            setupSearchBar()
        }
        
        if shouldAddSelectButton {
            setupSelectButton()
        }
        
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.keyboardDismissMode = .onDrag
        tableView.register(StudentCell.self, forCellReuseIdentifier: "StudentCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: shouldAddSearchBar ? searchBar.bottomAnchor : view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: shouldAddSelectButton ? selectButton.topAnchor : view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupSelectButton() {
        selectButton.setTitle("Select a student", for: .normal)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectButton)
        
        NSLayoutConstraint.activate([
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
//        selectButton.addTarget(self, action: #selector(selectButtonTapped), for: .touchUpInside)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func reloadFilterData(shouldReloadTableView: Bool = true) {
        if let filterText = filterText {
            filterDataSource(filterText)
        } else {
            resetDataSource()
        }
        
        if shouldReloadTableView {
            tableView.reloadData()
        }
    }
    
    private func resetDataSource() {
//        filteredMen = men
//        filteredWomen = women
    }
    
    private func filterDataSource(_ filterText: String) {
//        if filterText.count > 0 {
//            filteredMen = men.filter {
//                $0.lowercased().contains(filterText.lowercased())
//            }
//
//            filteredWomen = women.filter {
//                $0.lowercased().contains(filterText.lowercased())
//            }
//        } else {
//            resetDataSource()
//        }
    }
    
//    private func presentAlertForStudent(_ student: String, in viewController: UIViewController) {
//        let alertVC = UIAlertController(title: "Error", message: "Student \(student) already exists", preferredStyle: .alert)
//
//        alertVC.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
//
//        viewController.present(alertVC, animated: true, completion: nil)
//    }
    
    //MARK: - IBActions
    
    @objc private func selectButtonTapped() {
//        let vc = StudentViewController()
//        vc.studentManager = StudentManager()
//        vc.shouldAddSelectButton = false
//        vc.shouldAddSearchBar = true
//        vc.men = DataSource.menArray
//        vc.women = DataSource.womenArray
        
       // vc.delegate = self
        
//        vc.didSelectStudentClosure = { [weak self] student, gender, sender in
//            self?.didSelectStudent(student, gender: gender, sender: sender)
//        }
        
//        present(vc, animated: true)
    }
}

extension StudentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if dataSource[section].count == 0 {
            return nil
        }
        
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
        let student = dataSource[indexPath.section][indexPath.row]
        cell.nameLabel.text = student.name
        
        DataSource.fetchGithubUserAvatar(student.login) { [weak cell] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    cell?.avatarImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
}

extension StudentViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
//        delegate?.didSelectStudent(dataSource[indexPath.section][indexPath.row], gender: indexPath.section, sender: self)
//        didSelectStudentClosure?(dataSource[indexPath.section][indexPath.row], indexPath.section, self)
//
//        if !shouldAddSelectButton {
//            let object = NotificationObject(student: dataSource[indexPath.section][indexPath.row], gender: indexPath.section, sender: self)
//
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidSelectStudentNotification"), object: object)
//        }
            
    }
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        return shouldAddSelectButton
//    }
//
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        let nameToDelete = dataSource[indexPath.section][indexPath.row]
//        if editingStyle == .delete {
//            if indexPath.section == 0 {
//                if let index = men.firstIndex(of: nameToDelete) {
//                    men.remove(at: index)
//                }
//            } else {
//                if let index = women.firstIndex(of: nameToDelete) {
//                    women.remove(at: index)
//                }
//            }
//
//            reloadFilterData(shouldReloadTableView: false)
//
//            tableView.performBatchUpdates({
//                tableView.deleteRows(at: [indexPath], with: .fade)
//            }, completion: { finished in
//                tableView.reloadData()
//            })
//        }
//
//        saveData()
//    }
}

extension StudentViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterText = searchText
    }
}

extension StudentViewController: StudentViewControllerDelegate {
    func didSelectStudent(_ student: String, gender: Int, sender: UIViewController) {
        
//        var alreadyExist = false
//
//        if gender == 0 {
//            if men.contains(student) {
//                alreadyExist = true
//            }
//        } else {
//            if women.contains(student) {
//                alreadyExist = true
//            }
//        }
//
//        if alreadyExist {
//            presentAlertForStudent(student, in: sender)
//            return
//        }
//
//        sender.dismiss(animated: true, completion: nil)
//
//        if gender == 0 {
//            men.append(student)
//        } else {
//            women.append(student)
//        }
//
//        reloadFilterData()
//
//        saveData()
    }
}
