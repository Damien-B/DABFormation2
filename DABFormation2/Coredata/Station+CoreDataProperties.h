//
//  Station+CoreDataProperties.h
//  DABFormation2
//
//  Created by mac mini pprod 3 on 24/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Station.h"

NS_ASSUME_NONNULL_BEGIN

@interface Station (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSNumber *availableBikes;
@property (nullable, nonatomic, retain) NSNumber *availableBikeStands;
@property (nullable, nonatomic, retain) NSNumber *banking;
@property (nullable, nonatomic, retain) NSNumber *bikeStands;
@property (nullable, nonatomic, retain) NSNumber *bonus;
@property (nullable, nonatomic, retain) NSString *contractName;
@property (nullable, nonatomic, retain) NSDate *lastUpdate;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *number;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) NSNumber *isFavorite;

@end

NS_ASSUME_NONNULL_END
