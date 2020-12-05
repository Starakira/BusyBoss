//
//  CompanyProfileViewController.swift
//  BusyBoss
//
//  Created by richard santoso on 03/12/20.
//

import UIKit

class CompanyProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var companyProfileImage: UIImageView!
    @IBOutlet weak var companyNameLabel: UITextField!
    @IBOutlet weak var companyAddress: UITextField!
    @IBOutlet weak var companyPhoneNo: UITextField!
    @IBOutlet weak var companyEmail: UITextField!
    @IBOutlet weak var companyPICName: UITextField!
    @IBOutlet weak var companyProfileMenuTableView: UITableView!
    var menuList = [menu]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configTable()
        companyProfileMenuTableView.dataSource = self
        companyProfileMenuTableView.delegate = self
    }
    @IBAction func addPhotoButton(_ sender: Any) {
        let ivc = UIImagePickerController()
               ivc.sourceType = .photoLibrary
               ivc.delegate = self
               ivc.allowsEditing = true
               present(ivc, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "companyCell", for: indexPath)as!CompanyMenuTableViewCell
        let m = menuList[indexPath.row]
        cell.menuLabel.text = m.name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toBankAccount", sender: self)
        }
        else if indexPath.row == 1{
            let vc = storyboard?.instantiateViewController(identifier: "signature") as! SignatureViewController
                       self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func configTable(){
        menuList.append(menu(name: "bank account"))
        menuList.append(menu(name: "Signature"))
    }
   struct menu {
    let name : String
      }
}
 extension CompanyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            self.companyProfileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
