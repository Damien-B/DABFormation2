//
//  CloseStationsListViewController.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 18/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "CloseStationsListViewController.h"
#import "DataManager.h"
#import "UtilityManager.h"
#import "Station.h"
#import "CloseStationTableViewCell.h"

@interface CloseStationsListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *stationsListTableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation CloseStationsListViewController

@synthesize fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        DLog(@"error : %@", error.localizedDescription);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(NSFetchedResultsController *)fetchedResultsController {
    if(!fetchedResultsController){
        
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Station"];
        if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse){
            request.predicate = [NSPredicate predicateWithFormat:@"latitude >= %@ AND latitude <= %@ AND longitude >= %@ AND longitude <= %@", [NSNumber numberWithDouble:[UtilityManager sharedUtilityManager].locationManager.location.coordinate.latitude-closeStationsPositionDelta], [NSNumber numberWithDouble:[UtilityManager sharedUtilityManager].locationManager.location.coordinate.latitude+closeStationsPositionDelta], [NSNumber numberWithDouble:[UtilityManager sharedUtilityManager].locationManager.location.coordinate.longitude-closeStationsPositionDelta], [NSNumber numberWithDouble:[UtilityManager sharedUtilityManager].locationManager.location.coordinate.longitude+closeStationsPositionDelta]];
        }else{
            request.predicate = [NSPredicate predicateWithFormat:@"latitude >= %@ AND latitude <= %@ AND longitude >= %@ AND longitude <= %@", [NSNumber numberWithDouble:defaultLatitude-closeStationsPositionDelta], [NSNumber numberWithDouble:defaultLatitude+closeStationsPositionDelta], [NSNumber numberWithDouble:defaultLongitude-closeStationsPositionDelta], [NSNumber numberWithDouble:defaultLongitude+closeStationsPositionDelta]];
        }
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"availableBikeStands" ascending:YES]];
        [request setFetchBatchSize:20];
        
        NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[DataManager sharedDataManager].managedObjectContext sectionNameKeyPath:@"number" cacheName:nil];//@"closeStations"];
        controller.delegate = self;
        self.fetchedResultsController = controller;
    }
    return fetchedResultsController;
}

#pragma mark - UITableView DataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CloseStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"closeStationCell"];
    cell.titleLabel.text = ((Station *)[self.fetchedResultsController objectAtIndexPath:indexPath]).name;
    cell.subtitleLabel.text = [NSString stringWithFormat:@"%@ - %@", ((Station *)[self.fetchedResultsController objectAtIndexPath:indexPath]).latitude, ((Station *)[self.fetchedResultsController objectAtIndexPath:indexPath]).longitude];
    if([((Station *)[self.fetchedResultsController objectAtIndexPath:indexPath]).isFavorite  isEqual:@1]){
        cell.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:156.0/255.0 blue:18.0/255.0 alpha:1];
    }else{
        cell.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

#pragma mark - UITableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [((Station *)[self.fetchedResultsController objectAtIndexPath:indexPath]) changeIsFavorite];
    [tableView cellForRowAtIndexPath:indexPath].selected = false;
}


#pragma mark - NSFetchedResultsController Delegate

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.stationsListTableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            DLog(@"data change");
            CloseStationTableViewCell *cell = [self.stationsListTableView cellForRowAtIndexPath:indexPath];
            NSManagedObject *object = [controller objectAtIndexPath:indexPath];
            cell.titleLabel.text = [object valueForKey:@"name"];
            cell.subtitleLabel.text = [NSString stringWithFormat:@"%@ - %@", [object valueForKey:@"latitude"], [object valueForKey:@"longitude"]];
            if([[object valueForKey:@"isFavorite"]  isEqual:@1]){
                cell.backgroundColor = [UIColor colorWithRed:243.0/255.0 green:156.0/255.0 blue:18.0/255.0 alpha:1];
            }else{
                cell.backgroundColor = [UIColor clearColor];
            }
            break;
    }
}

@end
