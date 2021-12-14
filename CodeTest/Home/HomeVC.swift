//
//  HomeVC.swift
//  CodeTest
//
//  Created by logicloops on 13/12/21.
//

import UIKit

class TblParentUserData : UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var cellData : UserList!
   
}
class TblChildUserData : UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var cellData : ChildList!
}
class HomeVC: UIViewController {

    @IBOutlet weak var tblUserList: UITableView!
    @IBOutlet weak var txtSearch: UISearchBar!
    
    private let numberOfActualRowsForSection = 1
    static let apiLink = "http://139.162.53.200:3000/"
    var selectedCellIndexPath: IndexPath?
    var arrParent = [UserList]()
    var arrChild = [ChildList]()
    var arrMainParent : UserList?
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    deinit {
        
    }
    func mainThread(_ completion: @escaping () -> ()) {
        DispatchQueue.main.async {
             completion()
        }
    }
    func setUpView(){
        self.tblUserList.delegate = self
        self.tblUserList.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callGetUserInfo()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrParent.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrChild[section].isSelected  ? (1+numberOfActualRowsForSection) : 1
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tblUserList.dequeueReusableCell(withIdentifier: "TblParentUserData") as! TblParentUserData
            let data = arrParent[indexPath.section]
            cell.cellData = data
            cell.lblName.text = data.name
            cell.lblAge.text = "\(String(describing: data.age))"
            cell.lblEmail.text = data.email
            cell.contentView.tag = indexPath.section
            cell.selectionStyle = .none
           
            
            
            return cell
        }else{
            let cell = tblUserList.dequeueReusableCell(withIdentifier: "TblChildUserData") as! TblChildUserData
            let data = arrChild[indexPath.section]
            cell.cellData = data
            cell.lblName.text = data.name
            cell.lblAge.text = "\(String(describing: data.age))"
            cell.lblEmail.text = data.email
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            arrChild[indexPath.section].isSelected = !arrChild[indexPath.section].isSelected
            
            tblUserList.reloadSections([indexPath.section], with: .automatic)
        }
    }
    
}

extension HomeVC{
    func callGetUserInfo() {
        ApiCall().get(apiUrl: HomeVC.apiLink, model: UserList.self, isLoader: false) { (success, responseData) in
            if success, let responseData = responseData as? [UserList]{
                
                
                self.arrChild = responseData[0].child ?? []
               // self.arrChild = responseData
                self.tblUserList.reloadData()
            } else {
                self.mainThread {
                
                }
            }
        }
    }
}
