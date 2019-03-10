//
//  ViewController.swift
//  POC
//
//  Created by Ankush on 3/7/19.
//  Copyright © 2019 Reliance. All rights reserved.
//

import UIKit
import Kingfisher
class CountryVC: UIViewController {
    //MARK:VARIABLE DECELARATION
    private let viewModelCountry = CountryViewModel()
    private var dataSource = CountryDataSource()

    let countryDescTable:UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.estimatedRowHeight = 44.0
        table.rowHeight = UITableView.automaticDimension
        table.layoutMargins = .zero
        table.separatorInset = .zero
        table.separatorStyle = .singleLine;
        return table
    }()
    //MARK:LIFE CYCLE
     override func viewDidLoad() {
        super.viewDidLoad()

        customInit()
        fetchCountryDetail()
        setUpHandler()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillLayoutSubviews() {
        addConstraint()
    }

    //MARK:PRIVATE METHOD(S)
    
    func fetchCountryDetail()
    {
        showLoader(with: self.view)
        let servicePath = JCPostServicePath.countryDetail()
        viewModelCountry.callWebServices(servicePath: servicePath)
    }
    // Handler handle all the callbacks from View Mddek
    func setUpHandler()  {
        // Handle the success response from ViewModel
        viewModelCountry.successViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                hideLoader(parentView: (self?.view)!)
                self?.dataSource.countryDtailModels = self?.viewModelCountry.countryInfo!.rows ?? [CountryDetailModel]()
                self?.countryDescTable.reloadData()
                self?.title = self?.viewModelCountry.countryInfo?.title
                self?.viewModelCountry.countryInfo?.rows.count == 0 ? self?.countryDescTable.showEmptyScreen("No Data Found.") :self?.countryDescTable.showEmptyScreen("")
                self?.countryDescTable.refreshControl?.endRefreshing()

                }
        }
        // Handle the Alert Message from view model
         viewModelCountry.showAlertClosure = { [weak self] (messgae) in
            DispatchQueue.main.async {
                hideLoader(parentView: (self?.view)!)

                self?.countryDescTable.showEmptyScreen("No Data Found.")

                self?.popupAlert(title:"Alert", message:"No Data Found.", actionTitles: ["Ok"], actions:[{action1 in
                    }, nil])
                
            }
            } as ((String) -> ())
    }
    
    private func customInit()
    {
    countryDescTable.dataSource = dataSource
    countryDescTable.delegate = self
    self.view.addSubview(countryDescTable)
    countryDescTable.register(CountryTableViewCell.self, forCellReuseIdentifier: Constants.Indentifier.kCountryCell)
    countryDescTable.reloadData()
    countryDescTable.pullToRefresh() { [weak self] in
        self?.fetchCountryDetail()
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
extension CountryVC:UITableViewDelegate
{
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
    }
}

