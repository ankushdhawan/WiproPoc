//
//  ViewController.swift
//  POC
//
//  Created by Ankush on 3/7/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit
import Kingfisher
class CountryDetailVC: UIViewController {
    //MARK:VARIABLE DECELARATION
    private let viewModelCountry = CountryViewModel()

    let countryDescTable:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 44.0
        table.rowHeight = UITableView.automaticDimension
        table.layoutMargins = .zero
        table.separatorInset = .zero
        return table
    }()
    //MARK:LIFE CYCLE
     override func viewDidLoad() {
        super.viewDidLoad()
        customInit()
        setUpHandler()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillLayoutSubviews() {
        addConstraint()
    }

    //MARK:PRIVATE METHOD(S)
    func setUpHandler()  {
        
        let servicePath = JCPostServicePath.countryDetail()
        viewModelCountry.callWebServices(servicePath: servicePath)
        viewModelCountry.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {
               
                self?.countryDescTable.reloadData()
                //self?.navigationController?.popViewController(animated: false)
                
            }
        }
        
        viewModelCountry.showAlertClosure = { [weak self] (messgae) in
            DispatchQueue.main.async {
                
                self?.popupAlert(title:"Alert", message:"Invalid Credentail", actionTitles: ["Ok"], actions:[{action1 in
                    }, nil])
                
            }
            } as ((String) -> ())
    }
    
    private func customInit()
    {
    countryDescTable.dataSource = self
    countryDescTable.delegate = self
    self.view.addSubview(countryDescTable)
    countryDescTable.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Indentifier.kCountryCell)
    countryDescTable.reloadData()
    countryDescTable.pullToRefresh(self) {
            
        }
        
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
        return viewModelCountry.countryInfo?.rows.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Indentifier.kCountryCell, for: indexPath) as! CountryTableViewCell
        cell.selectionStyle = .none
        cell.configureView(model:viewModelCountry.countryInfo?.rows[indexPath.row])
        cell.awakeFromNib()
        return cell
    }
    
    
    
    
}
