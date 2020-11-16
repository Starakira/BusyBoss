//
//  ProductListBarangViewController.swift
//  Busy Boss
//
//  Created by Ryan Anslyno Khohari on 27/10/20.
//

import UIKit

class ProductListBarangViewController: UIViewController {
    
    @IBOutlet weak var TableBarangProductList: UITableView!
    var Dummy : [DummyDataTransaction]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let DummyManager : DummyDataManager = DummyDataManager()
        Dummy = DummyManager.Dummy
        TableBarangProductList.dataSource = self
        TableBarangProductList.delegate = self
        
    }
    
    
   

}

extension ProductListBarangViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddGoodDetailsSegue", sender: self)
    }
}

extension ProductListBarangViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListBarangViewCell", for: indexPath)as!ProductListBarangViewCell
        let Data = Dummy[indexPath.row]
        print (Data)
        cell.NamaBarangLabel.text = Data.transactionGoodName
        cell.JumlahStockBarang.text = String(Data.transactionStockNumber)
        cell.TotalHargaLabel.text = String(Data.transactionTotalValue)
        cell.GambarBarang.image = Data.transactionImage
        return cell
    }
}
