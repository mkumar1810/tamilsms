//
//  smsDBAsyncQueueProcess.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsDBAsyncQueueProcess.h"
#import "smsLocalStore.h"

static NSOperationQueue * s_ops_queue;
static smsLocalStore * s_storeDBOps;

@interface smsDBAsyncQueueProcess()

+ (void) addToQueueBlock:(NOPARAMCALLBACK) p_block;
+ (smsLocalStore*) getLocalStoreInstance;

@end

@implementation smsDBAsyncQueueProcess

+ (smsLocalStore*) getLocalStoreInstance
{
    if (!s_storeDBOps) {
        s_storeDBOps = [[smsLocalStore alloc] init];
    }
    return s_storeDBOps;
}


+ (void) getImageCategoryTitles:(ARRAYCALLBACK) p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSArray * l_categorylist = [[self getLocalStoreInstance] getMainCategoryTitlesForImgMsgs];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_categorylist);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}


+ (void) getTextCategoryTitles:(ARRAYCALLBACK) p_returnCB;
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSArray * l_categorylist = [[self getLocalStoreInstance] getMainCategoryTitlesForTxtMsgs];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_categorylist);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+ (void) getTextMsgForCategory:(NSInteger) p_categoryId andReturnCB:(ARRAYCALLBACK) p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSArray * l_categorylistMessage = [[self getLocalStoreInstance] getTextMsgForCategory:p_categoryId];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_categorylistMessage);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+(void) getImagMsgForCategory:(NSInteger)p_categoryId andReturnCB:(ARRAYCALLBACK)p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSArray * l_categoryImglistMessage = [[self getLocalStoreInstance] getImageMsgForCategory:p_categoryId];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_categoryImglistMessage);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+ (void) getTextSubCategoryTitles:(NSInteger) p_catgId andrReturnCb:(ARRAYCALLBACK) p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSArray * l_subCategorylist = [[self getLocalStoreInstance] getTextSubCategoryForMainCaregory:p_catgId];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_subCategorylist);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+ (void) getImageSubCategoryTitles:(NSInteger) p_catgId andrReturnCb:(ARRAYCALLBACK) p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSArray * l_subCategorylist = [[self getLocalStoreInstance] getImageSubCategoryForMainCaregory:p_catgId];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_subCategorylist);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+ (void) getSyncRelatedParamsWithReturnCB:(DICTIONARYCALLBACK) p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        NSDictionary * l_resultdict = [[self getLocalStoreInstance] getSyncParamsFromDB];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB(l_resultdict);
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+ (void) updateNewRecordIntoDB:(NSDictionary*) p_updateInfo withReturnCB:(NOPARAMCALLBACK) p_returnCB
{
    NOPARAMCALLBACK l_exeBlock = ^()
    {
        [[self getLocalStoreInstance] updateParsedDatasIntoDatabase:p_updateInfo];
        dispatch_async(dispatch_get_main_queue(),
                       ^{
                           p_returnCB();
                       });
    };
    [self addToQueueBlock:l_exeBlock];
}

+ (void) addToQueueBlock:(NOPARAMCALLBACK) p_block
{
    if (!s_ops_queue)
    {
        s_ops_queue = [[NSOperationQueue alloc] init];
        s_ops_queue.name = @"TruContacts DB queue";
        s_ops_queue.maxConcurrentOperationCount =  1;
    }
    [s_ops_queue addOperation:[[smsDBOperation alloc] initWithExecuteBlock:p_block]];
}


@end


@implementation smsDBOperation

- (id) initWithExecuteBlock:(NOPARAMCALLBACK) p_executeBlock
{
    self = [super init];
    if (self) {
        _executeBlock = p_executeBlock;
    }
    return self;
}

- (void) main
{
    _executeBlock();
}

@end