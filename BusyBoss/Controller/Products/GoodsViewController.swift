//
//  GoodsViewController.swift
//  Busy Boss
//
//  Created by richard santoso on 27/10/20.
//

import UIKit

class GoodsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var goodsTableView: UITableView!
    var goods : [goodsStruct]!
    override func viewDidLoad() {
        super.viewDidLoad()
        let GSManager : goodsStructManager = goodsStructManager ()
        goods = GSManager.goods
        goodsTableView.dataSource = self
        goodsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "goodsCell", for: indexPath)as!GoodsTableViewCell
        let g = goods[indexPath.row]
        cell.goodsLabel.text = g.productName
        cell.goodsImage.image = g.productImage
        cell.goodsPrice.text = String(g.productPrice)
        cell.goodsStock.text = String(g.productStock) + g.productUnit
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "goodsDetails") as! GoodsDetailsViewController
        vc.goods = goods[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
