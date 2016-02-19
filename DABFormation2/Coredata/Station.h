//
//  Station.h
//  DABFormation2
//
//  Created by mac mini pprod 3 on 18/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Station : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(Station *)addStationFromDictionary:(NSDictionary *)stationDictionary inContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Station+CoreDataProperties.h"
