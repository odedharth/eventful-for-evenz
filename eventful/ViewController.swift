//
//  ViewController.swift
//  eventful
//
//  Created by Admin on 8/4/15.
//  Copyright (c) 2015 Oded Harth. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    @IBOutlet weak var categories: UIPickerView!
    @IBOutlet weak var distances: UISlider!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    let categoriesData = ["Concerts","Festivals","Comedy","Family","Night life","Sports","Ticket deals"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categories.dataSource = self
        categories.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

