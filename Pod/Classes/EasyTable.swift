//
//  EasyTableViewController.swift
//  NextTrain
//
//  Created by Serge Neskoromny on 1/5/16.
//  Copyright © 2016 Sergey Nes. All rights reserved.
//

import UIKit

public protocol ClickHandler {
    func onCellClick(rowIndex: Int)
}

public protocol CellHolder {
    func getReuseIdentifier() -> String
    func inflate(tableView :UITableView, indexPath:NSIndexPath ) -> UITableViewCell!
    func onAction()
    func setDefaultValues()
    func setGroup(group: Int)
    func getGroup() -> Int
}

public class BaseViewHolder: CellHolder {
    public var group: Int = 0
    public var title: String = ""
    public var reuseIdentifier: String = ""
    public var selected:Bool = false
    
    public init(reuseIdentifier: String, title: String){
        self.title = title
        self.reuseIdentifier = reuseIdentifier
    }
    
    public convenience init(reuseIdentifier: String, title: String, group: Int){
        self.init(reuseIdentifier: reuseIdentifier, title: title)
        self.title = title
        self.reuseIdentifier = reuseIdentifier
        self.group = group
    }
    
    public convenience init(reuseIdentifier: String, title: String, selected: Bool, group: Int){
        self.init(reuseIdentifier: reuseIdentifier, title: title, group: group)
        self.selected = selected
    }
    
    public func getReuseIdentifier() -> String{
        return self.reuseIdentifier
    }
    
    public func inflate(tableView :UITableView, indexPath:NSIndexPath ) -> UITableViewCell!{
        return nil
    }
    
    public func onAction(){
    }
    
    public func setDefaultValues(){
        self.selected = false
    }
    
    public func setGroup(group: Int){
        self.group = group
    }
    
    public func getGroup() -> Int{
        return group
    }
}

public class EasyTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    public var rowSource: Array<CellHolder> = []
    
    @IBOutlet weak var tableView: UITableView!
    
    public var clickHandler: ClickHandler!
    
    public func reloadData(){
        tableView.reloadData()
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func getRow(index: Int) -> CellHolder{
        return rowSource[index]
    }
    
    public func addRow(row:CellHolder){
        rowSource.append(row)
    }
    
    // MARK: Data Sources and Delegates
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - Table Data Source
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowSource.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let holder: CellHolder = rowSource[indexPath.row]
        
        let cell =  holder.inflate(tableView, indexPath: indexPath)
        
        return cell
    }
    
    // MARK: - Table Delegate
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        clickHandler.onCellClick(indexPath.row)
    }
    
}
