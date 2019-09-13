//
//  ViewController.swift
//  Public Google Calendar
//
//  Created by Suyog Ghinmine on 12/09/19.
//  Copyright © 2019 Suyog Ghinmine. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    //Variable of data type Event:
    var event = Event(description: " ", htmlLink: " ", startDate: " ", startTime: " ", endDate: " ", endTime: " ")
    
    //IBOutlets:
    @IBOutlet weak var modalView: UIView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var starttimeLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var endTimeLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Properties for view:
        self.view.isOpaque = false
        view.backgroundColor = UIColor.clear
        
        //Properties for modalView:
        modalView.backgroundColor = UIColor.init(red: 186/255, green: 225/255, blue: 255/255, alpha: 1)
        modalView.layer.cornerRadius = 8
        modalView.clipsToBounds = true
        modalView.layer.borderWidth = 5
        modalView.layer.borderColor = UIColor.white.cgColor
        
        //Text in the labels:
        descriptionLabel.text = event.description
        startDateLabel.text = event.startDate
        starttimeLabel.text = event.startTime
        endDateLabel.text = event.endDate
        endTimeLabel.text = event.endTime
        
        //Text colour of the labels:
        descriptionLabel.textColor = UIColor.brown
        
        //Tap gesture:
        let tapOutsideGesture = UITapGestureRecognizer(target: self, action: #selector(touchOutside))
        view.addGestureRecognizer(tapOutsideGesture)
    }
    
    //Dismiss the view:
    @objc func touchOutside()
    {
        dismiss(animated: true, completion: nil)
    }
    

}

