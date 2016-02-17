//
//  DataManager.h
//  DABFormation2
//
//  Created by mac mini pprod 3 on 17/02/2016.
//  Copyright © 2016 mac mini pprod 3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

+ (DataManager *)sharedDataManager;
- (void)requestDataFromUrl:(NSString *)urlString;

@end
