//
//  ViewController.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import UIKit

class SOTableListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userDatas: [SOUserViewData]? = nil
    
    let cellIdentifier = "SOTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        let nm = SONetworkManager()
        let dm = SODataManager.init(networkManager: nm)
        
        dm.getData(successBlock: { (users) in
            
            
            self.userDatas = users.map({ (user) -> SOUserViewModel in
                SOUserViewModel(user: user)
            })
            
            DispatchQueue.main.async {
                print(self.userDatas ?? "nothing")
                self.tableView.reloadData()
            }
            
            
            
        }) { (error) in
            print(error)
        }
        
    }
}

extension SOTableListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userDatas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SOUserCellTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SOUserCellTableViewCell.")
        }
        
        if let userData = userDatas?[indexPath.row]  {
            cell.setupWith(user: userData)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SOUserCellTableViewCell {
            
            cell.toggleExpandedState()
            
            tableView.beginUpdates()
            tableView.endUpdates()
            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let userData = userDatas?[indexPath.row] {
            if userData.isInExpandedState { return 138 }
        }
        return 80
    }
    
}




/*
 
 
 When the app is launched, the user should be able to see a list of the top 20 StackOverflow users Each list item should contain user's profile image, name and reputation
 If the server is unavailable (e.g. offline), the user should see a list empty state with an error message Have cells be expandable (upon tapping the cell), with additional options to 'follow' and 'block' a user Follow/block functionality should just be locally simulated, i.e. no actual API call should be made. The meaning of following and blocking is explained in the points below.
 Users that are followed should show an indicator in the main part of the list item
 Users that are blocked should show in a disabled greyed-out list item; tapping on the item should not open the details view.
 Include 'unfollow' option in the view when a user is followed.
 Write unit tests wherever you see fit
 Emphasise testing and architecture
 Write in Swift
 No 3rd party frameworks - we want to see what you can do!
 Explain in a few words your design decisions you took developing the above app
 
 
 
 */
