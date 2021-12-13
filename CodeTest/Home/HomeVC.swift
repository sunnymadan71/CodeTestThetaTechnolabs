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
    var cellData : ChildUserListModel!
   
}
class TblChildUserData : UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var cellData : ChildUserListModel!
}
class HomeVC: UIViewController {

    @IBOutlet weak var tblUserList: UITableView!
    
    private let numberOfActualRowsForSection = 1
    static let apiLink = "http://1059-106-214-125-28.ngrok.io"
    var selectedCellIndexPath: IndexPath?
    var arrParent = [ChildUserListModel]()
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
        return arrParent[section].isSelected ? (1+numberOfActualRowsForSection) : 1
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
            let data = arrParent[indexPath.section]
            cell.cellData = data
            cell.lblName.text = data.name
            cell.lblAge.text = "\(String(describing: data.age))"
            cell.lblEmail.text = data.email
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            arrParent[indexPath.section].isSelected = !arrParent[indexPath.section].isSelected
            
            tblUserList.reloadSections([indexPath.section], with: .automatic)
        }
    }
}
extension UIView {
    fileprivate typealias ReturnGestureAction = (() -> Void)?
    fileprivate struct AssociatedObjectKeys {
        static var tapGestureRecognizer = "MediaViewerAssociatedObjectKey_mediaViewer1"
    }
    fileprivate var tapGestureRecognizerAction: ReturnGestureAction? {
        set {
            if let newValue = newValue {
                // Computed properties get stored as associated objects
                objc_setAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
            }
        }
        get {
            let tapGestureRecognizerActionInstance = objc_getAssociatedObject(self, &AssociatedObjectKeys.tapGestureRecognizer) as? ReturnGestureAction
            return tapGestureRecognizerActionInstance
        }
    }
    func handleTapToAction(action: (() -> Void)?)
     {
         let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHanldeAction))
         self.tapGestureRecognizerAction = action
         self.isUserInteractionEnabled = true
         self.addGestureRecognizer(gesture)
     }
    @objc func tapGestureHanldeAction()
    {
        if let action = self.tapGestureRecognizerAction {
            action?()
        } else {
            print("no action")
        }
    }
}
extension HomeVC{
    func callGetUserInfo() {
        ApiCall().get(apiUrl: HomeVC.apiLink, model: UserListModel.self, isLoader: false) { (success, responseData) in
            if success, let responseData = responseData as? UserListModel {
                self.arrParent = responseData.child ?? []
                self.tblUserList.reloadData()
            } else {
                self.mainThread {
                
                }
            }
        }
    }
}
