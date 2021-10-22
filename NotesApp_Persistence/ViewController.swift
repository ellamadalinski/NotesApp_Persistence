//
//  ViewController.swift
//  NotesApp_Persistence
//
//  Created by ELLA MADALINSKI on 10/22/21.
//

import UIKit

public struct Contact : Codable{
    var name : String
    var age : Int
}

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    var contacts : [Contact] = []
    @IBOutlet weak var nameOutlet: UITextField!
    @IBOutlet weak var ageOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        contacts.append(Contact(name: "Ella", age: 15))
        contacts.append(Contact(name: "Olivia", age: 16))
        
        if let items = UserDefaults.standard.data(forKey: "myContacts"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Contact].self, from: items){
                contacts = decoded
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = contacts[indexPath.row].name
        cell.detailTextLabel?.text = String(contacts[indexPath.row].age)
        return cell
    }
    
    
    @IBAction func addButtonOutlet(_ sender: UIButton) {
        contacts.append(Contact(name: nameOutlet.text!, age: Int(ageOutlet.text!)!))
        tableViewOutlet.reloadData()
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(contacts){
            UserDefaults.standard.set(encoded, forKey: "myContacts")
        }
    }
    
}

