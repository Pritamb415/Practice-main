//
//  ViewController.swift
//  Practice
//
//  Created by Admin on 17/10/24.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {

    
    @IBOutlet weak var productTableView: UITableView!
    var url : URL?
    var urlRequest : URLRequest?
    var urlSession : URLSession?
    var product : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jsonParse()
        registerXIB()
    }

    func jsonParse(){
        guard let url = URL(string: "https://fakestoreapi.com/products")else{
        print("invalid url")
            return
        }
        urlRequest = URLRequest(url: url)
        urlRequest?.httpMethod = "GET"
        
        urlSession = URLSession(configuration: .default)
    
        let dataTask = urlSession?.dataTask(with: urlRequest!) { urlData, urlResponse, urlError in
            
            if let error = urlError {
                            print("Error fetching data: \(error.localizedDescription)")
                            return
                }
            guard let data = urlData else{
                print("Error fetching data")
                return
            }
            
            self.product = try! JSONDecoder().decode([Product].self, from: data)
            print(data)
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }
        dataTask?.resume()
        
    }
    func registerXIB(){
        let uiNib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        self.productTableView.register(uiNib, forCellReuseIdentifier: "ProductTableViewCell")
    }

}

extension ViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        product.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.productTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell") as! ProductTableViewCell
        cell.productNameLabel.text = product[indexPath.row].title
        cell.productPriceLabel.text = "\(product[indexPath.row].price) $"
        cell.productDescriptionLabe.text = product[indexPath.row].description
        if let url = URL(string: product[indexPath.row].imageURL) {
                    cell.productImageView?.kf.setImage(with: url)
                }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250.0
    }
}
