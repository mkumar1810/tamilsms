//
//  smsBaseHomeController.m
//  tamilsms
//
//  Created by Mohan Kumar on 23/12/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsBaseHomeController.h"
#import "smsLocalStore.h"
#import "smsDBAsyncQueueProcess.h"
#import "smsSyncDBFromCloud.h"
#import "smsRESTProxy.h"
#import "smsAPIXMLDataParser.h"

@interface smsBaseHomeController ()<smsSyncDBFromCloudDelegates>

@property (nonatomic,strong) smsSyncDBFromCloud * smsSyncDBFromCloud;

@end

@implementation smsBaseHomeController

- (void)awakeFromNib
{
    [smsLocalStore getDBOpened];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.smsSyncDBFromCloud = [[smsSyncDBFromCloud alloc] init];
    self.smsSyncDBFromCloud.syncDelegate = self;
    [self checkForNewMessages];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) checkForNewMessages
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT , 0), ^(){
        [smsDBAsyncQueueProcess
         getSyncRelatedParamsWithReturnCB:^(NSDictionary * p_returnDict){
             [[smsRESTProxy alloc] initDatawithAPIType:@"DATACHECK"
                                        andInputParams:p_returnDict
                                       andReturnMethod:^(id p_pulledData)
              {
                  NSString * l_recdstring = [[NSString alloc]
                                             initWithData:p_pulledData
                                             encoding:NSUTF8StringEncoding];
                  l_recdstring = [NSString stringWithFormat:@"<data>%@</data>", [l_recdstring stringByReplacingOccurrencesOfString:@"[]" withString:@""]];
                  smsAPIXMLDataParser * l_xmlparser = [[smsAPIXMLDataParser alloc] initWithData:[l_recdstring dataUsingEncoding:NSUTF8StringEncoding]];
                  [l_xmlparser setShouldResolveExternalEntities:YES];
                  [l_xmlparser parse];
                  NSDictionary * l_resultDict = [l_xmlparser processedXMLResultDict];
                   if ([[l_resultDict valueForKey:@"smscount"] intValue]>0)
                   {
                       [self.smsSyncDBFromCloud startSyncingTamilSMSTable];
                   }
              }];
         }];
    });
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma syncing table class during operation to update data delegates

- (void) syncStartedForPosn:(NSInteger) p_posnNo
{
//    [_syncData setValue:@(0) forKey:@"pull"];
//    [_syncData setValue:@(0) forKey:@"pullperc"];
    //    self.navItem.rightBarButtonItems = [NSArray arrayWithObjects:self.bar_list_btn,nil];
}

- (void) syncCompletedForPosn:(NSInteger) p_posnNo noOfPulls:(NSInteger) p_pulls noOfPushes:(NSInteger) p_pushes withPullPerc:(NSInteger)p_pullPerc
{
//    [_syncData setValue:@(p_pulls) forKey:@"pull"];
//    [_syncData setValue:@(p_pullPerc) forKey:@"pullperc"];
}

- (void) syncTotallyCompleted
{
//    [self initializeData];
    (void) [NSTimer scheduledTimerWithTimeInterval:3600.0 target:self selector:@selector(checkForNewMessages) userInfo:nil repeats:NO];
}

@end
