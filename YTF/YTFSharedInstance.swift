//
//  YTFSharedInstance.swift
//  NativeProjectBootstrap
//
//  Created by ingouackaz on 13/10/2015.
//  Copyright © 2015 Fancy Pants Games. All rights reserved.
//

import UIKit
import CoreData



private let _YTFSharedInstance = YTF()

let iosDevices : [String] = ["iPhone","iPad"]


@objc protocol PeopplsRequestDelegate {
    optional func homeFeedRequestEnded(objects:[AnyObject]?)
    optional func userProfilRequestEnded(objects:[AnyObject]?)
    optional func feedRequestForCategoryEnded(objects:[AnyObject]?)
    optional func activityRequestForCurrentUserEnded(objects:[AnyObject]?)
    optional func feedRequestForBestAndWorstEnded(objects:[AnyObject]?)
    optional func feedRequestForUserProfilEnded(objects:[AnyObject]?)
}


class YTF  {
    
    //private let _appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
   // var _context : NSManagedObjectContext
    
    
   // var _CBCurrentUser : CBUser?
  //  var _CBSelectedEnnemyTeam : CBTeam?
    var _isTrainingMode: Bool = true

    //private let _appDel:AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    class var sharedInstance : YTF {
        return _YTFSharedInstance
    }
    
    
    
    init(){
       // self._context = self._appDel.managedObjectContext!
   
        //self.loadCoreDataBase()
    }
    
    
    func loadCoreDataBase() {
       /// var cb = CB.sharedInstance

      //  self.loadCBUserCoreData()
        
    }
    
    /*
    func loadCBUserCoreData()-> CBUser? {
        let request = NSFetchRequest(entityName:CBUserEntityName)
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try _context.executeFetchRequest(request)
            
            if(result.count > 0)
            {
                
                
                // on récupère l'entite User
                let user = result[0] as! CBUser
                self._CBCurrentUser = user
                CB.sharedInstance._CBCurrentUser = user
                print("CBUser loaded pseudo : \(user)")
                
                return user
            }
            else{
                print("NO CBUser found")

                return nil

            }
            // success ...
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
            // failure
            return nil
        }

    }
    */
    
    
    
    
    // Request
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.YTFS" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("YTFS", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

    
}