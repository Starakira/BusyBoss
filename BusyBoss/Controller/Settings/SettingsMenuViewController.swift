//
//  SettingsMenuViewController.swift
//  BusyBoss
//
//  Created by richard santoso on 03/12/20.
//

import UIKit

class SettingsMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var companyProfileImage: UIImageView!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    var menuList = [menu]()
    override func viewDidLoad() {
        super.viewDidLoad()
        menuTableView.dataSource=self
        menuTableView.delegate=self
        // Do any additional setup after loading the view.
        configTable()
    }
    func configTable(){
        menuList.append(menu(name: "Profile", image:#imageLiteral(resourceName: "person circle logo")))
        menuList.append(menu(name: "Company", image: #imageLiteral(resourceName: "building logo")))
        menuList.append(menu(name: "Documents", image: #imageLiteral(resourceName: "document logo")))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)as!MenuSettingsTableViewCell
            let m = menuList[indexPath.row]
             cell.menuLabel.text = m.name
             cell.menuImage.image = m.image
             return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = storyboard?.instantiateViewController(identifier: "userProfile") as! UserProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 1 {
            let vc = storyboard?.instantiateViewController(identifier: "companyProfile") as! CompanyProfileViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if indexPath.row == 2 {
            let alert = UIAlertController(title: "Alert", message: "This feature is still locked, Coming Soon.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
    struct menu {
        let name : String
        let image : UIImage
    }

}
