//
//  DataManager.h
//  DABFormation2
//
//  Created by mac mini pprod 3 on 17/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject


@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (DataManager *)sharedDataManager;
- (void)fetchAllStations;
- (void)fetchCloseStations;

@end
