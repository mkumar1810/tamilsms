//
//  smsSyncDBFromCloud.m
//  tamilsms
//
//  Created by Mohan Kumar on 03/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsSyncDBFromCloud.h"
#import "smsDBAsyncQueueProcess.h"
#import "smsRESTProxy.h"

@interface smsSyncDBFromCloud()
{
    NSInteger _syncError;
    NSInteger _totalRecs, _runCounter, _paginationRecs, _pushCount, _removedRecs;
    NSDictionary * _schemaDict;
    NSDictionary * _currSyncDict;
    NSString * _currProcTableName, * _currProcTableIdFldName;
    NSArray * _syncTableList;
}

@end

@implementation smsSyncDBFromCloud

- (void) startSyncingTamilSMSTable
{
    [self processSyncingofTables];
}


- (void) processSyncingofTables
{
    _pushCount = 0;
    if (_syncDelegate) [_syncDelegate syncStartedForPosn:0];
    _totalRecs = 0;
    _runCounter = 0;
    _removedRecs = 0;
    //NSDictionary * l_headerdata = [_syncTableList objectAtIndex:_currIndexNo];
    [smsDBAsyncQueueProcess
     getSyncRelatedParamsWithReturnCB:^(NSDictionary * p_returnDict){
         [[smsRESTProxy alloc] initDatawithAPIType:@"DATASYNC"
                                      andInputParams:p_returnDict
                                     andReturnMethod:^(id p_pulledData){
                                         [self handleReturnedData:p_pulledData];
                                     }];
    }];
}

- (void) handleReturnedData:(id) p_receivedData
{
    static NSInteger l_recdrecs = 0;
    NSError * l_parseerror = nil;
    NSArray * l_recdRawData;
    id l_returndict = [NSJSONSerialization
                       JSONObjectWithData:p_receivedData
                       options:NSJSONReadingMutableLeaves
                       error:&l_parseerror];
    
    NSInteger l_returnError = [[l_returndict valueForKey:@"error"] integerValue];
    if ((l_parseerror!=nil) | (l_returnError!=0))
    {
        _syncError++;
        l_recdrecs = 0;
        /*if (_syncDelegate) [_syncDelegate syncCompletedForPosn:0
                                                     noOfPulls:_runCounter
                                                    noOfPushes:_pushCount
                                                  withPullPerc:100];
        [self processSyncingofTables];*/
        //return;
    }
    @try {
        l_recdRawData = (NSArray*) [l_returndict valueForKey:@"Quotes"];
        _totalRecs = [l_recdRawData count];
        if (l_parseerror)
        {
            l_parseerror = nil;
            _syncError++;
        }
    }
    @catch (NSException *exception)
    {
        l_recdRawData = @[];
        _syncError++;
    }
    if (_syncError==0)
    {
        NSInteger l_currstartno = l_recdrecs;
        NSInteger l_currnoofrecs = [l_recdRawData count];
        NSInteger l_finalno = l_currstartno + l_currnoofrecs;
        l_recdrecs += l_currnoofrecs;
        if (l_currnoofrecs>0)
        {
            for (NSDictionary * l_tmpdict in [l_recdRawData copy])
            {
                [self postOneByOneToSQLiteDB:l_tmpdict lastNo:l_finalno];
            }
        }
        if ([l_recdRawData count]==0)
        {
            NSInteger l_currperc = 100;
            if (_totalRecs!=0)
            {
                l_currperc = 100* _runCounter / _totalRecs;
            }
             if (_syncDelegate) [_syncDelegate syncCompletedForPosn:0
                                                          noOfPulls:_runCounter
                                                         noOfPushes:_pushCount
                                                       withPullPerc:l_currperc];
        }
#ifdef DEBUG
        NSLog(@"the sync time noof recs : %ld ",(long)_totalRecs);
#endif
    }
    else
    {
        if (_syncDelegate)
            [_syncDelegate syncTotallyCompleted];
    }
}

- (void) postOneByOneToSQLiteDB:(NSDictionary*) p_postDict lastNo:(NSInteger) p_endNo
{
    static NSInteger l_prevProgPerc = 0;
    [smsDBAsyncQueueProcess updateNewRecordIntoDB:[p_postDict copy] withReturnCB:^(){
        _runCounter++;
        NSInteger l_currperc = 100* _runCounter / _totalRecs;
        NOPARAMCALLBACK l_regularProc = ^(){
            if (_runCounter==_totalRecs)
            {
                l_prevProgPerc = 0;
                 if (_syncDelegate) [_syncDelegate syncCompletedForPosn:0
                                                              noOfPulls:_runCounter
                                                             noOfPushes:_pushCount
                                                           withPullPerc:100];
                if (_syncDelegate)
                    [_syncDelegate syncTotallyCompleted];
            }
        };
        if (_syncDelegate)
        {
            if ((l_currperc - l_prevProgPerc)>1)
            {
                [_syncDelegate
                 syncCompletedForPosn:0
                 noOfPulls:_runCounter
                 noOfPushes:_pushCount
                 withPullPerc:l_currperc];
                l_prevProgPerc = l_currperc;
            }
            l_regularProc();
        }
        else
            l_regularProc();
    }];
}

@end
