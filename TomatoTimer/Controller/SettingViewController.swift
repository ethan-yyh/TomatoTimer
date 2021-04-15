//
//  SettingViewController.swift
//  TomatoTimer
//
//  Created by Ziyao Wang on 2021-04-02.
//

import UIKit


private let reuseIdentifier = "SettingsCell"

class SettingViewController: UIViewController {
    // MARK: - Properties
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var TableSetting: UITableView!
    private var tableView: UITableView!
    private var userInfoHeader: UserInfoHeader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    

    // MARK: - Helper Functions
    public func showSecondViewController() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "SettingViewController")

            show(secondVC, sender: self)
        }
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 40
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        let frame1 = CGRect(x: 0, y: 20, width: view.frame.width, height: 60)
        let placeholderInfoHeader = PlaceholderInfoHeader(frame: frame1)
        tableView.tableHeaderView = UIView()
      
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
        
        userInfoHeader = UserInfoHeader(frame: frame)
        tableView.tableHeaderView = placeholderInfoHeader
        //tableView.tableFooterView = userInfoHeader
    }
    
    
    @objc func rightHandAction() {
        
        
        
        self.performSegue(withIdentifier: "unwindToClockView", sender: self)
        self.dismiss(animated: true, completion: nil)
            print("done")
    }
    func configureUI() {
        configureTableView()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        navigationItem.title = "Settings"
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Settings")
        navItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .reply, target: self, action: #selector(rightHandAction))
        navBar.setItems([navItem], animated: false)
    }

}

extension UIViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return SettingSection.allCases.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingSection(rawValue: section) else{return 0}
        switch section{
        case .general: return generalOption.allCases.count
        case .period: return timeOption.allCases.count
        //default: return 0
        }
    }
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .black
        let title  = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .white
        title.text=SettingSection(rawValue: section)?.description
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints=false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive=true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive=true
        
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40;//Choose your custom row height
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        
        cell.contentView.isUserInteractionEnabled = false
        guard let section = SettingSection(rawValue: indexPath.section) else{return UITableViewCell()}
        switch section{
        case .general:
            guard let general = generalOption(rawValue: indexPath.row)else{return UITableViewCell()}
            cell.sectionType = general
        case .period:
            guard let period = timeOption(rawValue: indexPath.row)else{return UITableViewCell()}
            cell.sectionType = period

       // default: return cell
        }
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .period:
            print(timeOption(rawValue: indexPath.row)?.description as Any)
            switch timeOption(rawValue: indexPath.row)?.description {
            case "Minutes per Tomato Session":
                let curr=UserDefaults.standard.integer(forKey: "TS_Time")
                //1. Create the alert controller.
                let alert = UIAlertController(title: "Tomato Session", message: "How long do you want your tomato session to be? (Enter 25 for 25 minutes)", preferredStyle: .alert)
                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    textField.text = String(curr)
                    textField.textAlignment = .center
                }
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                    UserDefaults.standard.set(textField!.text,forKey: "TS_Time")
                    tableView.deselectRow(at: indexPath, animated: true)
                    print("Text field: \(String(describing: textField!.text))")
                    
                }))
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
            case "Minutes per Short Break":
                print("Short Break")
                let curr=UserDefaults.standard.integer(forKey: "SB_Time")
                //1. Create the alert controller.
                let alert = UIAlertController(title: "Short Break Setting", message: "How long do you want your short break to be? (Enter 5 for 5 minutes)", preferredStyle: .alert)
                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    textField.text = String(curr)
                    textField.textAlignment = .center
                }
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                    UserDefaults.standard.set(textField!.text,forKey: "SB_Time")
                    tableView.deselectRow(at: indexPath, animated: true)
                    print("Text field: \(String(describing: textField!.text))")
                }))
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
            case "Minutes per Long Break":
                print("1311")
                let curr=UserDefaults.standard.integer(forKey: "LB_Time")
                //1. Create the alert controller.
                let alert = UIAlertController(title: "Long Break Setting", message: "How long do you want your long break to be? (Enter 20 for 20 minutes)", preferredStyle: .alert)
                //2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    textField.text = String(curr)
                    textField.textAlignment = .center
                }
                // 3. Grab the value from the text field, and print it when the user clicks OK.
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
                    let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
                    UserDefaults.standard.set(textField!.text,forKey: "LB_Time")
                    tableView.deselectRow(at: indexPath, animated: true)
                    print("Text field: \(String(describing: textField!.text))")
                }))
                // 4. Present the alert.
                self.present(alert, animated: true, completion: nil)
            default:
                print("Something wrong with section type!")
            }
        default:
            print("No Action")
        }
    }
    
}



