//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Manpreet Singh on 2020-02-26.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoriesArray = [ItemCategory]()
    let context = PersistenceService.context

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.CategoryCell, for: indexPath)
        cell.textLabel?.text = categoriesArray[indexPath.row].name
        return cell
    }

    @IBAction func addItemPressed(_ sender: Any) {
            var textField = UITextField()
            let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Done", style: .default) { (action) in
                if textField.text != "" {
                    let category = ItemCategory(context: self.context)
                    category.name = textField.text!
                    self.categoriesArray.append(category)
                    self.saveData()
                }
            }
            alert.addTextField { (textfield) in
                textfield.placeholder = "Create new item"
                textField = textfield
            }
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
}

// MARK:- Table View Delegate

extension CategoryViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: K.goToItemsSegue, sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoriesArray[indexPath.row]
        }
    }
}


// MARK:- CRUD Operations
extension CategoryViewController {

    func loadData(with request: NSFetchRequest<ItemCategory> = ItemCategory.fetchRequest())  {
        do {
            categoriesArray = try context.fetch(request)
        } catch {
            print("Error while loading \(error)")
        }
    }

    func saveData() {
        PersistenceService.saveContext()
        tableView.reloadData()
    }

}
