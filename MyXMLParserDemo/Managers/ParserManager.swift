//
//  ParserManager.swift
//  MyXMLParserDemo
//
//  Created by RocoTech Server on 20/08/2017.
//  Copyright © 2017 Ihar Karalko. All rights reserved.
//

import Foundation

final class Parser: NSObject, XMLParserDelegate {
  
  static let manager = Parser()
  
  var url = URL(string: "https://news.tut.by/rss/sport.rss")
  
  var eName           = String()
  var feedTitle       = String()
  var feedPubDate     = String()
  var feedImageUrl    = String()
  var feedLink        = String()
  var feedDescription = String()
  
  var insideItem = false
  var feeds      = [Feed]()
  
  func getFeeds(callback: (_ results: [Feed]?)->()) {
    guard let url = self.url else {return}
    guard let parser = XMLParser(contentsOf: url) else {return}
    parser.delegate = self
    let result = parser.parse()
    if result {
      callback(feeds)
    }
  }
  
  // MARK: - XML PARSE DELEGATE
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    eName = elementName
    if elementName == "item"{
      insideItem      = true
      feedTitle       = String()
      feedPubDate     = String()
      feedImageUrl    = String()
      feedLink        = String()
      feedDescription = String()
    }
    if insideItem {
      if elementName == "media:content"{
        if let imageUrl = attributeDict["url"]{
          feedImageUrl = imageUrl
        }
      }
    }
  }
  
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    if !data.isEmpty {
      if eName == "title"{
        feedTitle += data
      }
      else if eName == "pubDate"{
        feedPubDate += data
      }
      else if eName == "link"{
        feedLink += data
      }
      else if eName == "description"{
        feedDescription += data
      }
    }
  }
  
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    let feed = Feed()
    if elementName == "item"{
      feed.title               = feedTitle
      feed.date                = feedPubDate
      let dateFormatter        = DateFormatter()
      dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss +zzzz"
      feed.dateDate            = dateFormatter.date(from: self.feedPubDate)
      feed.descriptionFeed     = feedDescription
      feed.imageUrl            = feedImageUrl
      feeds.append(feed)
      insideItem               = false
    }
  }
  
}
