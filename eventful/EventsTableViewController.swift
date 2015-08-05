//
//  EventsTableViewController.swift
//  eventful
//
//  Created by Admin on 8/5/15.
//  Copyright (c) 2015 Oded Harth. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {

    var apiQuery : NSURL?
    var eventsArray : [Event] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getEvents(self.apiQuery!)
        println(self.apiQuery)

    }
    
    func getEvents(url : NSURL) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let data = NSData(contentsOfURL: url, options: nil, error: nil)
            var jsonError : NSError?
            if let dataDictionary : NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: &jsonError) as? NSDictionary {
                if let eventsDictionary = dataDictionary["events"] as? NSDictionary {
                    println(dataDictionary["events"] as? NSDictionary)
                    if let eventsList = eventsDictionary["event"] as? NSArray {
                        for event in eventsList {
                            println(event["city_name"])
                            var newEvent = Event(title: event["title"] as! NSString,
                                venue: event["venue_name"] as! NSString,
                                date: event["start_time"] as! NSString)
                            newEvent.latitude = event["latitude"] as? NSString
                            newEvent.longitude = event["longitude"] as? NSString
                            
                            if let images = event["image"] as? NSDictionary {
                                if let medSize = images["medium"] as? NSDictionary {
                                    newEvent.imageURL = medSize["url"] as? NSString
                                }
                            }
                            
                            if let performers = event["performers"] as? NSDictionary {
                                newEvent.performers = []
                                if let performersArray = performers["performer"] as? NSArray {
                                    for performer in performersArray {
                                        newEvent.performers?.append(performer["name"] as! String)
                                    }
                                }
                                if let performer = performers["performer"] as? NSDictionary {
                                    newEvent.performers?.append(performer["name"] as! String)
                                }
                            }
                            
                            self.eventsArray.append(newEvent)
                        }
                    }
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    println(self.eventsArray.count)
                    self.tableView.reloadData()
                }
                
                
            } else {
                if let error = jsonError {
                    println(error)
                }
                
            }
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.eventsArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : EventCell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath) as! EventCell
        
        let event = eventsArray[indexPath.row]
        cell.eventTitle.text = "Title: " + (event.title as! String)
        cell.eventVenue.text = "Venue: " + (event.venue as! String)
        cell.eventLong.text = "Long: " + (event.longitude! as String)
        cell.eventLat.text = "Lat: " + (event.latitude! as String)
        
        
        return cell
        
    }

}
