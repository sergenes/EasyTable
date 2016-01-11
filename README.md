# EasyTable

[![CI Status](http://img.shields.io/travis/Serge Neskoromny/EasyTable.svg?style=flat)](https://travis-ci.org/Serge Neskoromny/EasyTable)
[![Version](https://img.shields.io/cocoapods/v/EasyTable.svg?style=flat)](http://cocoapods.org/pods/EasyTable)
[![License](https://img.shields.io/cocoapods/l/EasyTable.svg?style=flat)](http://cocoapods.org/pods/EasyTable)
[![Platform](https://img.shields.io/cocoapods/p/EasyTable.svg?style=flat)](http://cocoapods.org/pods/EasyTable)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Sample
1. Implement your custom cells
```swift
class SimpleViewCell: UITableViewCell {
@IBOutlet weak var titleLabel: UILabel!
}

public class SimpleViewHolder: BaseViewHolder {
weak var cell:SimpleViewCell?


override public func inflate(tableView :UITableView, indexPath:NSIndexPath ) -> UITableViewCell{
self.cell = tableView.dequeueReusableCellWithIdentifier(self.getReuseIdentifier(), forIndexPath: indexPath) as? SimpleViewCell

self.cell!.titleLabel!.text = self.title

return self.cell!
}

}

class OptionViewCell: UITableViewCell {

@IBOutlet weak var checkImage: UIImageView!

@IBOutlet weak var titleLabel: UILabel!
}

class OptionViewHolder: BaseViewHolder {

weak var cell:OptionViewCell?


override func inflate(tableView :UITableView, indexPath:NSIndexPath ) -> UITableViewCell{
let cell = tableView.dequeueReusableCellWithIdentifier(getReuseIdentifier(), forIndexPath: indexPath) as! OptionViewCell
cell.titleLabel!.text = self.title
cell.checkImage!.hidden = !selected


return cell
}

override func onAction(){
self.selected = !self.selected
}

}
```
2. Make the controller in your storyboard, place UITableView, and define temlates for your cells.
3. Link all of it, and use:

```swift
override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
if segue.identifier == "embeddedTable" {
easyTableController = segue.destinationViewController as? EasyTableViewController

easyTableController.clickHandler = self

easyTableController.addRow(SimpleViewHolder(reuseIdentifier: "SimpleViewCell", title: "Home", group: 1))
easyTableController.addRow(SimpleViewHolder(reuseIdentifier: "SimpleViewCell", title: "Map", group: 1))
easyTableController.addRow(SimpleViewHolder(reuseIdentifier: "SimpleViewCell", title: "About", group: 1))

easyTableController.addRow(MenuSeparatorHolder(reuseIdentifier: "MenuSeparatorCell", title: "Language"))

easyTableController.addRow(OptionViewHolder(reuseIdentifier: "OptionViewCell", title: "English", selected: true, group: 2))
easyTableController.addRow(OptionViewHolder(reuseIdentifier: "OptionViewCell", title: "Hebrew", selected: false, group: 2))
easyTableController.addRow(OptionViewHolder(reuseIdentifier: "OptionViewCell", title: "Russian", selected: false, group: 2))
easyTableController.addRow(OptionViewHolder(reuseIdentifier: "OptionViewCell", title: "Arabic", selected: false, group: 2))

easyTableController.addRow(MenuSeparatorHolder(reuseIdentifier: "MenuSeparatorCell", title: "Season"))

easyTableController.addRow(OptionViewHolder(reuseIdentifier: "OptionViewCell", title: "Winter", selected: true, group: 3))
easyTableController.addRow(OptionViewHolder(reuseIdentifier: "OptionViewCell", title: "Summer", selected: false, group: 3))


}
}

func onCellClick(rowIndex: Int){
if let slideMenuController = self.slideMenuController() {

let holder: CellHolder = easyTableController.getRow(rowIndex)

if holder is SimpleViewHolder {
if rowIndex == 0 {
if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("main.screen") {
slideMenuController.changeMainViewController(controller, close: true)
}
}else if rowIndex == 1 {

}else if rowIndex == 2 {

}
}else if holder is OptionViewHolder{

for item in easyTableController.rowSource {
if item.getGroup() == holder.getGroup() {
item.setDefaultValues()
}
}


holder.onAction()
easyTableController.reloadData()
}


slideMenuController.closeLeft()
}

}
```
## Requirements

## Installation

EasyTable is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "EasyTable"
```

## Author

Serge Nes, serge.nes@gmail.com

## License

EasyTable is available under the Apache-2.0 license. See the LICENSE file for more info.
