//
//  SOTableListViewController.swift
//  StackOverflow
//
//  Created by Viswambharan Nikitha, Abhilash on 27/02/2020.
//  Copyright © 2020 Viswambharan Nikitha, Abhilash. All rights reserved.
//

import UIKit

class TableViewHelper {
    
    class func EmptyMessage(message:String, viewController: UITableView) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: viewController.bounds.size.width, height: viewController.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.backgroundView = messageLabel;
        viewController.separatorStyle = .none;
    }
}

class SOTableListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var activity: UIActivityIndicatorView?
    
    var actionDelegate: UserListViewInteractionProtocol!
    var userDatas: [SOUserViewData]? = nil
    
    let cellIdentifier = "SOTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        self.showActivity(loading: true)
    }
    
    func showActivity(loading: Bool) {
        
        if activity == nil {
            activity = UIActivityIndicatorView(style: .large)
        }
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.tableView.frame.width, height:  self.tableView.frame.height))
        
        activity!.frame = rect
        self.tableView.addSubview(activity!)
        loading ? activity!.startAnimating() : activity!.stopAnimating()
        
    }
}

extension SOTableListViewController: UserListView {
    
    func showUserList(users: [SOUserViewData]) {
        
        showActivity(loading: false)
        
        self.userDatas = users
        self.tableView.reloadData()
        
    }
    
    func showError(errorMessage: String) {
        showActivity(loading: false)
        TableViewHelper.EmptyMessage(message: errorMessage, viewController: self.tableView)
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
            cell.blockAction = { [weak self] user in
                
                self?.actionDelegate.blockingActionRequested(on: user, index: indexPath.row)
                self?.toggleStateOfCell(cell: cell)
            }
            
            cell.followAction = { [weak self] user in
                
                self?.actionDelegate.followActionRequested(on: user, index: indexPath.row)
            }
            
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let userData = userDatas?[indexPath.row] {
            if userData.isBlocked { return }
        }
        
        if let cell = tableView.cellForRow(at: indexPath) as? SOUserCellTableViewCell {
            toggleStateOfCell(cell: cell)
        }
        
    }
    
    private func toggleStateOfCell(cell: SOUserCellTableViewCell) {
        
        cell.toggleExpandedState()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let userData = userDatas?[indexPath.row] {
            if userData.isInExpandedState { return 138 }
        }
        return 84
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
