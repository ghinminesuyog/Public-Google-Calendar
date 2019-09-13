//
//  TableViewController.swift
//  Public Google Calendar
//
//  Created by Suyog Ghinmine on 12/09/19.
//  Copyright © 2019 Suyog Ghinmine. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //Array of events:
    var eventArray : [Event] = []
    
    var htmlLink = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        parseJSON()
        
        navigationItem.title = "Events"
        
        tableView.backgroundColor = UIColor.white
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        //Text for each label in the cell
        cell.descriptionLabel.text = eventArray[indexPath.row].description
        cell.startDateLabel.text = eventArray[indexPath.row].startDate
        cell.startTimeLabel.text = eventArray[indexPath.row].startTime
        cell.endDateLabel.text = eventArray[indexPath.row].endDate
        cell.endTimeLabel.text = eventArray[indexPath.row].endTime

        cell.backgroundColor = UIColor.init(red: 186/255, green: 225/255, blue: 255/255, alpha: 1)
        
        cell.descriptionLabel.textColor = UIColor.brown
        cell.startDateLabel.textColor = UIColor.black
        cell.startTimeLabel.textColor = UIColor.brown
        cell.endDateLabel.textColor = UIColor.black
        cell.endTimeLabel.textColor = UIColor.brown
        
        cell.layer.cornerRadius = 20
        cell.clipsToBounds = true
        
        cell.layer.borderWidth = 3
        cell.layer.borderColor = UIColor.white.cgColor

        cell.selectionStyle = .none
        //Pastel pink (255,179,186)
        //Pastel yellow (255,255,186)
        //Pastel green (186,255,201)
        //Pastel blue (186,225,255)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sbObj = UIStoryboard(name: "Main", bundle: nil)
        let svcObj = sbObj.instantiateViewController(withIdentifier: "ViewControllerSB") as! ViewController
        svcObj.event = eventArray[indexPath.row]
        svcObj.modalPresentationStyle = .overCurrentContext
        navigationController?.present(svcObj, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TableViewController
{
    func parseJSON(){
        
            //Remove all data from the array:
            eventArray.removeAll()
            
            //The URL request:
        var urlrequest = URLRequest(url: URL(string: "https://www.googleapis.com/calendar/v3/calendars/{CALENDAR-ID}}/events?key={APIKEY}}")!)
            //The URL request method:
            urlrequest.httpMethod = "GET"
            
            //Configuration and session of the URL:
            let config = URLSessionConfiguration.default
            let session = URLSession.init(configuration: config)
            
            //Task:
            let task = session.dataTask(with: urlrequest) { (data, response, error) in
                do
                {
                    //The outermost dictionary:
                    let resultDictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                    
                    //The array within the outermost dictionary:
                    let resultArray = resultDictionary.value(forKey: "items") as! NSArray
                    //Iterating over the array:
                    for i in 0 ..< resultArray.count
                    {
                        //The dictionary within the array:
                        let dic = resultArray[i] as! NSDictionary
                        
                        //Description string within the dictionary:
                        let description = dic.value(forKey: "summary") as! String
                        
                        //Start dictionary and the dateTime string within start dictionary:
                        let startDic = dic.value(forKey: "start") as! NSDictionary
                        var startDate = " "
                        var startTime = " "
                        //Check if it contains start time:
                        //If it is just date and no time:
                        if startDic["dateTime"] == nil{
                            //Start value is just a date
                            startDate = startDic.value(forKey: "date") as! String
                            //Date as dd-MM-YYYY instead of YYYY-MM-dd:
                            startDate = "\(startDate.split(separator: "-")[2])-\(startDate.split(separator: "-")[1])-\(startDate.split(separator: "-")[0])"
                        }
                            //If it is both date and time:
                        else{
                            startDate = startDic.value(forKey: "dateTime") as! String
                            startDate = "\(startDate.dropLast(15)) \(startDate.dropFirst(11).dropLast(6))"
                            //Start time:
                            startTime = "\(startDate.split(separator: " ")[1])"
                            //Start date in dd-MM-YYYY format:
                            startDate = "\(startDate.split(separator: " ")[0].split(separator: "-")[2])-\(startDate.split(separator: " ")[0].split(separator: "-")[1])-\(startDate.split(separator: " ")[0].split(separator: "-")[0])"
                        }
                        
                        //End dictionary and the dateTime string within end dictionary:
                        let endDic = dic.value(forKey: "end") as! NSDictionary
                        var endDate = " "
                        var endTime = " "
                        //Check if it contains start time:
                        //If it is just date and no time:
                        if endDic["dateTime"] == nil{
                            //End value is just a date
                            endDate = endDic.value(forKey: "date") as! String
                            //End date in dd-MM-YYYY format:
                            endDate = "\(endDate.split(separator: "-")[2])-\(endDate.split(separator: "-")[1])-\(endDate.split(separator: "-")[0])"
                        }
                            //If it is both date and time:
                        else{
                            endDate = endDic.value(forKey: "dateTime") as! String
                            endDate = "\(endDate.dropLast(15)) \(endDate.dropFirst(11).dropLast(6))"
                            //End time:
                            endTime = "\(endDate.split(separator: " ")[1])"
                            //End date in dd-MM-YYYY:
                            endDate = "\(endDate.split(separator: " ")[0].split(separator: "-")[2])-\(endDate.split(separator: " ")[0].split(separator: "-")[1])-\(endDate.split(separator: " ")[0].split(separator: "-")[0])"
                        }
                        
                        //HTML link to the event:
                        let html = dic.value(forKey: "htmlLink") as! String
                        
                        //Define an object element of class Events with title, start time, end time, etc:
                        let element = Event(description: description, htmlLink: html, startDate: startDate, startTime: startTime, endDate: endDate, endTime: endTime)
                        
                        //Append this to the array of Events object:
                        self.eventArray.append(element)
                    }
                }
                //Rearrange by start date:
                self.eventArray.sort(by: {$0.startDate < $1.startDate})
                //Reload the table:
                DispatchQueue.main.async(execute: {self.tableView.reloadData()})
            }
            task.resume()
        }
    }

