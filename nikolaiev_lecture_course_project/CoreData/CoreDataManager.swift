
import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func saveMainContext()
    func saveBackgorundContext()
}

final class CoreDataManager {
    
    static let shared: CoreDataManager = {
        guard let modelURL = Bundle(for: CoreDataManager.self).url(forResource: Constants.dataModel, withExtension: "momd"),
              let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
                  fatalError("No Core Data stack")
              }
        let persistentContainer = NSPersistentContainer(name: Constants.dataModel, managedObjectModel: managedObjectModel)
        
        return CoreDataManager(persistentContainer: persistentContainer)
    }()
    
    private let persistentContainer: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    let backgroundContext: NSManagedObjectContext
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
        self.persistentContainer.loadPersistentStores { _, error in
        }
        
        self.backgroundContext = persistentContainer.newBackgroundContext()
        backgroundContext.automaticallyMergesChangesFromParent = true
        backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        mainContext.automaticallyMergesChangesFromParent = true
        mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
}

extension CoreDataManager: CoreDataManagerProtocol {
    
    func saveMainContext() {
        save(context: self.mainContext)
    }
    
    func saveBackgorundContext() {
        save(context: self.backgroundContext)
    }
    
    private func save(context: NSManagedObjectContext) {
        context.perform {
            guard context.hasChanges else {
                return
            }
            do {
                try context.save()
            } catch {
                context.rollback()
                let contextError = error as NSError
                assertionFailure(contextError.localizedDescription)
            }
        }
    }
    
}
