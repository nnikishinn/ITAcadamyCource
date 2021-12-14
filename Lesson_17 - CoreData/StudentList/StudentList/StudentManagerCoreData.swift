//
//  StudentManagerCoreData.swift
//  StudentList
//
//  Created by Nickolai Nikishin on 11.12.21.
//

import CoreData

class StudentManagerCoreData {
    
    func saveData(menList: [String]?, womenList: [String]?) {
        
        clearData()
        saveMenList(menList)
        saveWomenList(womenList)
    }
    
    private func saveMenList(_ menList: [String]?) {
        guard let menList = menList else {
            return
        }

        for name in menList {
            saveStudent(name: name, gender: 0)
        }
    }
    
    private func saveWomenList(_ womenList: [String]?) {
        guard let womenList = womenList else {
            return
        }
        
        womenList.forEach { name in
            saveStudent(name: name, gender: 1)
        }
    }
    
    private func saveStudent(name: String, gender: Int) {
        let student = Student(context: context)
        student.name = name
        student.gender = Int16(gender)
        do {
            try context.save()
        } catch {
            print("Unable to Student \(error)")
        }
    }
    
    func readWomenList() -> [String] {
        readStudent(gender: 1)
    }
    
    private func readStudent(gender: Int) -> [String] {
        let fetchRequest = NSFetchRequest<Student>(entityName: "Student")
        fetchRequest.predicate = NSPredicate(format: "gender == %i", gender)
        var array: [String] = []
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                if let name = object.name {
                    array.append(name)
                }
            }
        }
        
        return array
    }
    
    func readMenList() -> [String] {
        readStudent(gender: 0)
    }
    
    private func clearData() {
        let fetchRequest = NSFetchRequest<Student>(entityName: "Student")
        
        if let result = try? context.fetch(fetchRequest) {
            for object in result {
                context.delete(object)
            }
        }
    }
    
    private lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        
//        let momdName = "StudentCoreDataModel" //pass this as a parameter
//        //...
//
//        guard let modelURL = Bundle(for: type(of: self)).url(forResource: momdName, withExtension:"momd") else {
//                fatalError("Error loading model from bundle")
//        }
//
//        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
//            fatalError("Error initializing mom from: \(modelURL)")
//        }
        
        let container = NSPersistentContainer(name: "StudentCoreDataModel")


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

    private func saveContext () {
        let context = context
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
