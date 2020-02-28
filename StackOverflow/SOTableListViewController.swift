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
    
    var userData: [SOUser]? = nil
    
      let cellIdentifier = "SOTableViewCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        
        let nm = SONetworkManager()
        let dm = SODataManager.init(networkManager: nm)
         
        dm.getData(successBlock: { (users) in
            
            
            self.userData = users
            
            DispatchQueue.main.async {
                print(self.userData ?? "nothing")
                self.tableView.reloadData()
            }
            

            
        }) { (error) in
            print(error)
        }
        
    }
}

extension SOTableListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SOUserCellTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
            
        cell.userNameLabel.text = userData?[indexPath.row].name
        return cell
        
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
