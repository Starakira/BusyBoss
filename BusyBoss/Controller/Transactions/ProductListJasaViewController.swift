//
//  ProductListJasaViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ProductListJasaViewController: UIViewController {
    
    @IBOutlet weak var TableJasaProductList: UITableView!
    var Dummy : [DummyDataTransaction]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        TableJasaProductList.dataSource = self
        TableJasaProductList.delegate = self
        
    }
}

extension ProductListJasaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddServiceDetailsSegue", sender: self)
    }
}

extension ProductListJasaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListJasaViewCell", for: indexPath)as!ProductListJasaViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        cell.NameJasaLabel.text = Data.transactionServiceName
        cell.TotalHargaLabel.text = String( Data.transactionTotalValue)
        return cell
    }
}
