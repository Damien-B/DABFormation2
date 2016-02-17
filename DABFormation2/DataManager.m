//
//  DataManager.m
//  DABFormation2
//
//  Created by mac mini pprod 3 on 17/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import "DataManager.h"
#import "AFNetworking/AFNetworking.h"

@implementation DataManager

+ (DataManager *)sharedDataManager {
    static DataManager *sharedManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManager = [[DataManager alloc] init];
    });
    return sharedManager;
}

- (void)requestDataFromUrl:(NSString *)urlString {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(!error){
            NSLog(@"Data received with response : %@", response);
            NSLog(@"Data : %@", responseObject);
        }else{
            NSLog(@"ERROR : %@", error);
        }
    }];
    [dataTask resume];
}

@end
