//
//  smsAsyncImageFetch.h
//  tamilsms
//
//  Created by Mohan Kumar on 23/09/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "smsDefaults.h"

@interface smsAsyncImageFetch : NSObject

- (void) initDatawithFileName:(NSString*) p_fileName andReturnMethod:(DICTIONARYCALLBACK) p_returnCB;
- (void) initWithFileNameDelete:(NSString*) p_fileName;

@end
