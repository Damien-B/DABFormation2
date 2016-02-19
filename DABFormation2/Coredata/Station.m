//
//  Station.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 18/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "Station.h"
#import "DataManager.h"

@implementation Station

// Insert code here to add functionality to your managed object subclass

+(Station *)addStationFromDictionary:(NSDictionary *)stationDictionary inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Station"];
    request.predicate = [NSPredicate predicateWithFormat:@"number == %@", stationDictionary[@"number"]];
    NSArray *stationsWithCurrentNumber = [[DataManager sharedDataManager].managedObjectContext executeFetchRequest:request error:nil];
    if(stationsWithCurrentNumber.count == 0){
        Station *newStation = [NSEntityDescription insertNewObjectForEntityForName:@"Station" inManagedObjectContext:context];
        newStation.address = stationDictionary[@"address"];
        newStation.availableBikes = stationDictionary[@"available_bikes"];
        newStation.availableBikeStands = stationDictionary[@"available_bike_stands"];
        newStation.banking = stationDictionary[@"banking"];
        newStation.bikeStands = stationDictionary[@"bike_stands"];
        newStation.bonus = stationDictionary[@"bonus"];
        newStation.contractName = stationDictionary[@"contract_name"];
        newStation.lastUpdate = [NSDate dateWithTimeIntervalSince1970:[stationDictionary[@"last_update"] integerValue]/1000];
        NSDictionary *position = stationDictionary[@"position"];
        newStation.latitude = position[@"lat"];
        newStation.longitude = position[@"lng"];
        newStation.name = stationDictionary[@"name"];
        newStation.number = stationDictionary[@"number"];
        newStation.status = stationDictionary[@"status"];
        //DLog(@"station %@ added to core data", newStation.name);
        return newStation;
    }else{
        Station *station = stationsWithCurrentNumber[0];
        station.address = stationDictionary[@"address"];
        station.availableBikes = stationDictionary[@"available_bikes"];
        station.availableBikeStands = stationDictionary[@"available_bike_stands"];
        station.banking = stationDictionary[@"banking"];
        station.bikeStands = stationDictionary[@"bike_stands"];
        station.bonus = stationDictionary[@"bonus"];
        station.contractName = stationDictionary[@"contract_name"];
        station.lastUpdate = [NSDate dateWithTimeIntervalSince1970:[stationDictionary[@"last_update"] integerValue]/1000];
        NSDictionary *position = stationDictionary[@"position"];
        station.latitude = position[@"lat"];
        station.longitude = position[@"lng"];
        station.name = stationDictionary[@"name"];
        station.number = stationDictionary[@"number"];
        station.status = stationDictionary[@"status"];
        //DLog(@"station %@ updated in core data", station.name);
        return station;
    }
}
@end
