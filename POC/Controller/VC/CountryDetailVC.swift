//
//  ViewController.swift
//  POC
//
//  Created by Ankush on 3/7/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit

class CountryDetailVC: UIViewController {
    //MARK:VARIABLE DECELARATION
    let countryDescTable:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 44.0
        table.rowHeight = UITableView.automaticDimension
       return table
    }()
    //MARK:LIFE CYCLE
     override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillLayoutSubviews() {
        addConstraint()
    }

    //MARK:PRIVATE METHOD(S)
    private func customInit()
    {
    countryDescTable.dataSource = self
    countryDescTable.delegate = self
    self.view.addSubview(countryDescTable)
    countryDescTable.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Indentifier.kCountryCell)
    countryDescTable.reloadData()
    }
    private func addConstraint()
   {
    let views: [String: Any] = [
    "tableView": countryDescTable]
    var allConstraints: [NSLayoutConstraint] = []
   
    // SET LEADIING AND TRIALING CONSTRAINT TABLEVIEW
    
    let tableViewVerticalConstraints = NSLayoutConstraint.constraints(
    withVisualFormat: "V:|-0-[tableView]-0-|",
    metrics: nil,
    views: views)
    allConstraints += tableViewVerticalConstraints
    
    // SET TOP AND BOTTOM CONSTRAINT TABLEVIEW

    let tableViewHorizontalConstraints = NSLayoutConstraint.constraints(
    withVisualFormat: "H:|-0-[tableView]-0-|",
    metrics: nil,
    views: views)
    allConstraints += tableViewHorizontalConstraints
    NSLayoutConstraint.activate(allConstraints)

    }
    

}
extension CountryDetailVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension CountryDetailVC:UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifier.kCountryCell, for: indexPath) as! CountryTableViewCell
        cell.titleLable.text = "Name of Ankush"
        cell.descriptionLable.text = "sadasdkahdsakdhkjlashdksajhdhasldhasldsaldhlasdlasdlassdasjkhdsahdsaasdjakdhaskjdhakshdkashdhasdhashdsahdhaslhdlashdlashdhasdhlashdaskdsasajkdashdaskjdhs"
        cell.imageView?.backgroundColor = UIColor.red
        cell.awakeFromNib()
       return cell
    }
    
    
    
    
}
