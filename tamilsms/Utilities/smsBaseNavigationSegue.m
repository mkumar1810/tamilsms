//
//  smsBaseNavigationSegue.m
//  tamilsms
//
//  Created by Mohan Kumar on 10/09/15.
//  Copyright (c) 2015 Mohan Kumar. All rights reserved.
//

#import "smsBaseNavigationSegue.h"

@implementation smsBaseNavigationSegue


- (instancetype) initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if (self) {
        //
    }
    return self;
}

- (void) perform
{
    UIViewController * l_src = (UIViewController*) self.sourceViewController;
    UIViewController * l_dest = (UIViewController*) self.destinationViewController;
    if ([l_dest respondsToSelector:@selector(initializeDataWithParams:)])
    {
        id<smsCustNaviDelegates>  l_srcdlg = (id<smsCustNaviDelegates>) l_src;
        id<smsCustNaviDelegates>  l_destdlg = (id<smsCustNaviDelegates>) l_dest;
        [l_destdlg initializeDataWithParams:l_srcdlg.navigateParams];
    }
    [l_src.navigationController pushViewController:l_dest animated:YES];
}

@end
