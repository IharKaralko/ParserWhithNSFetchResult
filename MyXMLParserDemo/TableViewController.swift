//
//  TableViewController.swift
//  MyXMLParserDemo
//
//  Created by Ihar Karalko on 7/4/17.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  
  var fetchedResultsController: NSFetchedResultsController<FeedCoreData>?

   override func viewWillAppear(_ animated: Bool) {
    navigationController?.hidesBarsOnSwipe = true
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "SPORT NEWS"
        let fetchRequest = FeedCoreData.fetchRequestExecute()
        fetchRequest.sortDescriptors  = []
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.stack.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController?.delegate = self
        do {
            try fetchedResultsController?.performFetch()
        } catch let error as NSError {
            print("Fetching error: \(error), \(error.userInfo)")
        }
    }
  
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
      guard let sections = fetchedResultsController?.sections else {
        return 0
      }
      return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      guard let sectionInfo = fetchedResultsController?.sections?[section] else {
        return 0
      }
      return sectionInfo.numberOfObjects
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        configure(cell: cell, for: indexPath)
        return cell
    }
  
    func configure(cell: CustomTableViewCell, for indexPath: IndexPath) {
        if let feed = fetchedResultsController?.object(at: indexPath) {
            cell.configure(title: feed.title!, date: feed.date!, imageUrl: feed.imageUrl!, imageData: feed.imageNSData as Data?)
        }
    }
  
  // MARK: - FetchResultController
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .insert:
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
    case .move:
      tableView.moveRow(at: indexPath!, to: newIndexPath!)
    case .update:

        tableView.reloadData()
    }
  }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detail"{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                let dvc = segue.destination as! ViewController
                let feed = fetchedResultsController?.object(at: indexPath)
                
                dvc.title = feed?.title
                dvc.detailFeed.date = feed?.date
                dvc.detailFeed.title = feed?.title
                dvc.detailFeed.descriptionFeed = feed?.descriptionFeed
                dvc.detailFeed.imageNSData = feed?.imageNSData
            }
        }
    }
    
}























