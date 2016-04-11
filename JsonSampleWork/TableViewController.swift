//
//  TableViewController.swift
//  JsonSampleWork
//
//  Created by Mengistayehu Mamo on 4/7/16.
//  Copyright © 2016 Mengistayehu Mamo. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let freeKivaUrl = "https://api.kivaws.org/v1/loans/newest.json"
    var loans = [Loan]()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getLetestLaon()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func getLetestLaon(){
        let urlRequest = NSURLRequest(URL: NSURL(string: freeKivaUrl)!)
        let urlsesssion = NSURLSession.sharedSession()
        let task = urlsesssion.dataTaskWithRequest(urlRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("\(error)")
                return
            }
            if let data = data {
                self.loans = self.parsedJsonData(data)
                NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    func parsedJsonData(data: NSData) -> [Loan]{
         var loans = [Loan]()
        do{
            let jsonResults = try NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as? NSDictionary
            
            let jsonLoans = jsonResults?["loans"] as! [AnyObject]
            for jsonLoan in jsonLoans {
                let loan = Loan()
                loan.name = jsonLoan["name"] as! String
                loan.amount = jsonLoan["loan_amount"] as! Int
                loan.use = jsonLoan["use"] as! String
                let location = jsonLoan["location"] as! [String:AnyObject]
                loan.country = location["country"] as! String
                loans.append(loan)
             }
        } catch{
            print(error)
        }
        
       return loans
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return loans.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DisplayTableViewCell
        
        cell.name.text = loans[indexPath.row].name
        cell.country.text = loans[indexPath.row].country
        cell.amount.text = "$\(loans[indexPath.row].amount)"
        cell.use.text = loans[indexPath.row].use;
      
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
