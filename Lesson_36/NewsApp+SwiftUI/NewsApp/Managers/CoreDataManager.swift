//
//  CoreDataManager.swift
//  NewsApp
//
//  Created by Nastenka on 28.02.22.
//

import Foundation
import CoreData

class ManagerCoreData {

    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    func deleteNews () {
        let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
        if let news = try? context.fetch(fetchRequest) {
            news.forEach {
                context.delete($0)
            }
        }
       saveContext()
    }
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension ManagerCoreData: PersistenceProtocol {
    func readFavorites() -> [Article] {
        let fetchRequest = NSFetchRequest<News>(entityName: "News")
        if let result = try? context.fetch(fetchRequest) {
            return result.map{
                Article(author: $0.author,
                        title: $0.title!,
                        description: $0.descriptionText!,
                        url: $0.url!,
                        urlToImage: $0.urlToImage,
                        publishedAt: $0.publishedAt!,
                        content: $0.content!)
            }
        }
        return []
    }
    
    func saveFavorites(_ favorites: [Article]) {
        deleteNews()
        favorites.forEach {
            let entity = News(context: context)
            entity.author = $0.author
            entity.title = $0.title
            entity.descriptionText = $0.description
            entity.url = $0.url
            entity.urlToImage = $0.urlToImage
            entity.publishedAt = $0.publishedAt
            entity.content = $0.content
           saveContext()
        }
    }
}


