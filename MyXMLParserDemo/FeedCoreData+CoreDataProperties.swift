//
//  FeedCoreData+CoreDataProperties.swift
//  MyXMLParserDemo
//
//  Created by RocoTech Server on 21/08/2017.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import Foundation
import CoreData

extension FeedCoreData {

    @nonobjc public class func fetchRequestExecute() -> NSFetchRequest<FeedCoreData> {
        return NSFetchRequest<FeedCoreData>(entityName: "FeedCoreData")
    }

    @NSManaged public var date: String?
    @NSManaged public var descriptionFeed: String?
    @NSManaged public var imageNSData: NSData?
    @NSManaged public var imageUrl: String?
    @NSManaged public var title: String?

}
