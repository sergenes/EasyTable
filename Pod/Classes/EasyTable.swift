//
//  EasyTableViewController.swift
//  NextTrain
//
//  Created by Serge Neskoromny on 1/5/16.
//  Copyright © 2016 Sergey Nes. All rights reserved.
//

import UIKit

protocol ClickHandler {
    func onCellClick(rowIndex: Int)
}

protocol CellHolder {
    func getReuseIdentifier() -> String
    func inflate(tableView :UITableView, indexPath:NSIndexPath ) -> UITableViewCell!
    func onAction()
    func setDefaultValues()
    func setGroup(group: Int)
    func getGroup() -> Int
}

class BaseViewHolder: CellHolder {
    var group: Int = 0
    var title: String = ""
    var reuseIdentifier: String = ""
    var selected:Bool = false
    
    init(reuseIdentifier: String, title: String){
        self.title = title
        self.reuseIdentifier = reuseIdentifier
    }
    
    convenience init(reuseIdentifier: String, title: String, group: Int){
        self.init(reuseIdentifier: reuseIdentifier, title: title)
        self.title = title
        self.reuseIdentifier = reuseIdentifier
        self.group = group
    }
    
    convenience init(reuseIdentifier: String, title: String, selected: Bool, group: Int){
        self.init(reuseIdentifier: reuseIdentifier, title: title, group: group)
        self.selected = selected
    }
    
    func getReuseIdentifier() -> String{
        return self.reuseIdentifier
    }
    
    func inflate(tableView :UITableView, indexPath:NSIndexPath ) -> UITableViewCell!{
        return nil
    }
    
    func onAction(){
    }
    
    func setDefaultValues(){
        self.selected = false
    }
    
    func setGroup(group: Int){
        self.group = group
    }
    
    func getGroup() -> Int{
        return group
    }
}

class EasyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var rowSource: Array<CellHolder> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    var clickHandler: ClickHandler!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addRow(row:CellHolder){
        rowSource.append(row)
    }
    
    // MARK: Data Sources and Delegates
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Table Data Source
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let holder: CellHolder = rowSource[indexPath.row]
        
        let cell =  holder.inflate(tableView, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: - Table Delegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        clickHandler.onCellClick(indexPath.row)
    }
    
}
