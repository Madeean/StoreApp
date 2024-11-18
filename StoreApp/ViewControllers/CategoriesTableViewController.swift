//
//  ViewController.swift
//  StoreApp
//
//  Created by made reihan on 17/11/24.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    private var client = StoreHTTPClient()
    private var categories: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Categories"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryTableViewCell")
        
        Task{
            await populateCategories()
            tableView.reloadData()
        }
    }
    
    private func populateCategories() async {
        do{
            categories = try await client.getAllCategories()
            print(categories)
        } catch {
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = categories[indexPath.row]
        self.navigationController?.pushViewController(ProductsTableViewController(category: category), animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator

        let category = categories[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = category.name

        // Gambar default alternatif
        let placeholderURL = "https://i.imgur.com/eGOUveI.jpeg"
        loadImage(from: category.image, placeholder: placeholderURL) { image in
            configuration.image = image
            configuration.imageProperties.maximumSize = CGSize(width: 75, height: 75)
            cell.contentConfiguration = configuration
        }
        
        return cell
    }

    private func loadImage(from urlString: String, placeholder: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            fetchPlaceholderImage(placeholder, completion: completion)
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                self.fetchPlaceholderImage(placeholder, completion: completion)
            }
        }
    }

    private func fetchPlaceholderImage(_ urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let placeholderURL = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(nil)
            }
            return
        }
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: placeholderURL), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }

}

