//
//  CoreDataStack.swift
//  MyXMLParserDemo
//
//  Created by RocoTech Server on 20/08/2017.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
  
  static let stack = CoreDataStack()
  
  static let modelName = "MyXMLParserDemo"
  
  // MARK: - Core Data stack
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container                     = NSPersistentContainer(name: modelName)
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func saveInBackground(feeds: [Feed]) {
    persistentContainer.performBackgroundTask { context in
      feeds.forEach({ feed in
        let corefeed      = FeedCoreData(context: self.persistentContainer.viewContext)
        corefeed.title    = feed.title
        corefeed.date     = feed.date
        corefeed.imageUrl = feed.imageUrl
        guard let url = URL(string: feed.imageUrl), let imageData = try? Data(contentsOf: url) else { return }
        corefeed.imageNSData = imageData as NSData
        self.saveContext()
      })
    }
  }
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}
