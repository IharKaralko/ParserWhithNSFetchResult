//
//  ViewController.swift
//  MyXMLParserDemo
//
//  Created by Ihar Karalko on 7/4/17.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageViewNews: UIImageView!
    var stringURL: String?
    var feed: FeedCoreData = FeedCoreData()
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
         let imageFeed = UIImage(data: feed.imageUrl! as Data)
        
        imageViewNews.image = imageFeed
        
           tableView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
           tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0
        {
            let cellOne = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! CellOneTableViewCell
            
            
            cellOne.titleLabel.text = feed.title
            cellOne.pubDateLabel.text = feed.date
            
            return cellOne
        } else {
            
            let cellTwo = tableView.dequeueReusableCell(withIdentifier: "cellTwo", for: indexPath) as! CellTwoTableViewCell
            
            let fullDescriptionArr = feed.descriptionFeed?.components(separatedBy: "/>")
            let onlyText = fullDescriptionArr?[1].components(separatedBy: "<")
            
            cellTwo.descriptionLabel.text = onlyText?[0]
            
            return cellTwo
        }

    }
}
