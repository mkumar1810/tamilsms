//
//  smsCommonUtilities.h
//  tamilsms
//
//  Created by Mohan Kumar on 31/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface smsCommonUtilities : NSObject

+ (void) addSMSItemToFavourite:(NSNumber *) p_MsgId;
+ (void) removeSMSItemToFavourite:(NSNumber *) p_MsgId;
+ (BOOL) isTheSMSIsInFavourite:(NSNumber*) p_MsgId;

@end
