//
//  smsDBAsyncQueueProcess.h
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 arun benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "smsDefaults.h"

@interface smsDBAsyncQueueProcess : NSObject

+ (void) getTextCategoryTitles:(ARRAYCALLBACK) p_returnCB;
+ (void) getImageCategoryTitles:(ARRAYCALLBACK) p_returnCB;
+ (void) getTextMsgForCategory:(NSInteger) p_categoryId andReturnCB:(ARRAYCALLBACK) p_returnCB;
+ (void) getImagMsgForCategory:(NSInteger) p_categoryId andReturnCB:(ARRAYCALLBACK) p_returnCB;
+ (void) getTextSubCategoryTitles:(NSInteger) p_catgId andrReturnCb:(ARRAYCALLBACK) p_returnCB;
+ (void) getImageSubCategoryTitles:(NSInteger) p_catgId andrReturnCb:(ARRAYCALLBACK) p_returnCB;
+ (void) getSyncRelatedParamsWithReturnCB:(DICTIONARYCALLBACK) p_returnCB;
+ (void) updateNewRecordIntoDB:(NSDictionary*) p_updateInfo withReturnCB:(NOPARAMCALLBACK) p_returnCB;

@end

@interface smsDBOperation : NSOperation
{
    NOPARAMCALLBACK _executeBlock;
}

- (id) initWithExecuteBlock:(NOPARAMCALLBACK) p_executeBlock;

@end