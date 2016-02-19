//
//  ViewController.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 17/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"
#import <NotificationCenter/NotificationCenter.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *stationsSavedLabel;
@property (weak, nonatomic) IBOutlet UIButton *goToTableViewButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[DataManager sharedDataManager] fetchAllStations];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stationsSavedInCoreData) name:NotificationAllStationsSaved object:nil];
}

-(void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)stationsSavedInCoreData {
    self.stationsSavedLabel.hidden = NO;
    self.goToTableViewButton.enabled = YES;
    [[DataManager sharedDataManager] fetchCloseStations];
}

@end
