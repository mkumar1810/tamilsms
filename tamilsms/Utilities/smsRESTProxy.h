//
//  smsRESTProxy.h
//  tamilsms
//
//  Created by Mohan Kumar on 03/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "smsDefaults.h"

@interface smsRESTProxy : NSObject

- (void) initDatawithAPIType:(NSString*) p_apiType andInputParams:(NSDictionary*) p_prmDict andReturnMethod:(GENERICCALLBACK) p_returnMethod;

@end
