//
//  smsCommonUtilities.m
//  tamilsms
//
//  Created by Mohan Kumar on 31/01/16.
//  Copyright © 2016 Kuttyveni Computing Center. All rights reserved.
//

#import "smsCommonUtilities.h"

@implementation smsCommonUtilities

+ (void) addSMSItemToFavourite:(NSNumber *) p_MsgId
{
    NSMutableArray * l_favItems = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"favourites"]];
    if (!l_favItems)
    {
        l_favItems = [NSMutableArray new];
    }
    if (![l_favItems containsObject:p_MsgId])
    {
        [l_favItems addObject:p_MsgId];
        [[NSUserDefaults standardUserDefaults] setValue:l_favItems forKey:@"favourites"];
    }
}

+ (void) removeSMSItemToFavourite:(NSNumber *) p_MsgId
{
    NSMutableArray * l_favItems = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"favourites"]];
    if (!l_favItems)
    {
        return;
    }
    if ([l_favItems containsObject:p_MsgId])
    {
        [l_favItems removeObject:p_MsgId];
        [[NSUserDefaults standardUserDefaults] setValue:l_favItems forKey:@"favourites"];
    }
}

+ (BOOL) isTheSMSIsInFavourite:(NSNumber*) p_MsgId
{
    NSMutableArray * l_favItems = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] valueForKey:@"favourites"]];
    if (!l_favItems)
    {
        return NO;
    }
    if ([l_favItems containsObject:p_MsgId])
    {
        return YES;
    }
    return NO;
}

@end
