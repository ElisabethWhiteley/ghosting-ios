//
//  PersistenceManager.swift
//  GreenEggs
//
//  Created by Elisabeth Whiteley on 06/09/2020.
//

import CoreData
import SwiftUI

class PersistenceManager {
  let persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Model")
      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              fatalError("Unresolved error \(error), \(error.userInfo)")
          }
      })
    
      return container
  }()

  init() {
    let center = NotificationCenter.default
    let notification = UIApplication.willResignActiveNotification

    center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
      guard let self = self else { return }

      if self.persistentContainer.viewContext.hasChanges {
        try? self.persistentContainer.viewContext.save()
      }
    }
  }
    

}
