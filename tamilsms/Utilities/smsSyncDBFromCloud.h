//
//  smsSyncDBFromCloud.h
//  tamilsms
//
//  Created by Mohan Kumar on 03/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "smsDefaults.h"

@protocol smsSyncDBFromCloudDelegates <NSObject>

//- (void) syncTablesListFetched:(NSArray*) p_tablesList;
- (void) syncStartedForPosn:(NSInteger) p_posnNo;
- (void) syncCompletedForPosn:(NSInteger) p_posnNo noOfPulls:(NSInteger) p_pulls noOfPushes:(NSInteger) p_pushes withPullPerc:(NSInteger) p_pullPerc;

@end

@interface smsSyncDBFromCloud : NSObject

@property (nonatomic, weak) id<smsSyncDBFromCloudDelegates> syncDelegate;

- (void) startSyncingTamilSMSTable;

@end
