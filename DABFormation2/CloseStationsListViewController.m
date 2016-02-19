//
//  CloseStationsListViewController.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 18/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "CloseStationsListViewController.h"
#import "DataManager.h"
#import "Station.h"
#import "closeStationTableViewCell.h"

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
        request.predicate = [NSPredicate predicateWithFormat:@"latitude >= %@ AND latitude <= %@ AND longitude >= %@ AND longitude <= %@", [NSNumber numberWithDouble:defaultLatitude-closeStationsPositionDelta], [NSNumber numberWithDouble:defaultLatitude+closeStationsPositionDelta], [NSNumber numberWithDouble:defaultLongitude-closeStationsPositionDelta], [NSNumber numberWithDouble:defaultLongitude+closeStationsPositionDelta]];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"availableBikes" ascending:YES], [NSSortDescriptor sortDescriptorWithKey:@"availableBikeStands" ascending:YES]];
        [request setFetchBatchSize:20];
        
        NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[DataManager sharedDataManager].managedObjectContext sectionNameKeyPath:@"availableBikes" cacheName:@"closeStations"];
        controller.delegate = self;
        self.fetchedResultsController = controller;
    }
    return fetchedResultsController;
}

#pragma mark - UITableView Delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    closeStationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"closeStationCell"];
    cell.titleLabel.text = ((Station *)[self.fetchedResultsController objectAtIndexPath:indexPath]).name;
    return cell;
}

@end
