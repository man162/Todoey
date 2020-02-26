//
//  PersistenceService.swift
//  Todoey
//
//  Created by Manpreet Singh on 2020-02-26.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation
import CoreData

// MARK:- Core Data Stack
class PersistenceService {

    private init() {}

    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    static var persistentContainer: NSPersistentContainer = {
          let container = NSPersistentContainer(name: "DataModel")
          container.loadPersistentStores(completionHandler: { (storeDescription, error) in
              if let error = error as NSError? {
                  fatalError("Unresolved error \(error), \(error.userInfo)")
              }
          })
          return container
      }()

      // MARK: - Core Data Saving support

      static func saveContext () {
          let context = persistentContainer.viewContext
          if context.hasChanges {
              do {
                  try context.save()
                print("Saved")
              } catch {
                  let nserror = error as NSError
                  fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
              }
          }
      }

}
