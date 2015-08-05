//
//  ViewController.swift
//  eventful
//
//  Created by Admin on 8/4/15.
//  Copyright (c) 2015 Oded Harth. All rights reserved.
//

import UIKit

struct APIStrings {
    
    // Eventful API URL Strings
    static let ApiRoot = "http://api.eventful.com/json/events/search?"
    static let ApiKey = "app_key=4nrBdpDJGpNF35RQ"
    static let LocationMethod = "&location="
    static let Category = "&category="
    static let WithinMethod = "&within="
 //   static let EFPageSizeMethod = "&page_size="
 //   static let EFPageNumber = "&page_number="
}

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var categories: UIPickerView!
    @IBOutlet weak var distances: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    let categoriesData = ["music","conference","food","art"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categories.dataSource = self
        categories.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func searchButtonClicked(sender: UIButton) {
        searchEventsFromApi()
    }
    
    func searchEventsFromApi() {
        println(getEventfulURL())
    }
    
    func getEventfulURL() -> NSURL? {
        var category = self.categoriesData[categories.selectedRowInComponent(0)]
        var urlString = APIStrings.ApiRoot + APIStrings.ApiKey +
            APIStrings.Category + category +
            APIStrings.LocationMethod + "San+Francicso" +
            APIStrings.WithinMethod + Int(self.distances.value).description
        
        return NSURL(string: urlString)
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        var currentValue = Int(sender.value)
        distanceLabel.text = "\(currentValue) km"
    }
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesData.count
    }
    
    //MARK: Delegates
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return categoriesData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }


}

