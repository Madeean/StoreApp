//
//  ProductsTableViewController.swift
//  StoreApp
//
//  Created by made reihan on 18/11/24.
//

import Foundation
import UIKit
import SwiftUI

class ProductsTableViewController: UITableViewController {
    
    private var category: Category
    private var client = StoreHTTPClient()
    private var products: [Product] = []
    
    init(category: Category) {
        self.category = category
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.name
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ProductTableViewCell")
        
        Task {
            await populateProducts()
        }
    }
    
    private func populateProducts() async {
        do {
            products = try await client.getProductsByCategory(categoryId: category.id)
            tableView.reloadData()
        } catch {
            print(error)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(co der:) has not been implemented")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath)
        
        let product = products[indexPath.row]
        
//        var configuration = cell.defaultContentConfiguration()
//        configuration.text = product.title
//        configuration.secondaryText = product.description
//        cell.contentConfiguration = configuration
        
        cell.contentConfiguration = UIHostingConfiguration(content: {
            ProductCellView(product: product)
        })
        
        return cell
    }
    
}
