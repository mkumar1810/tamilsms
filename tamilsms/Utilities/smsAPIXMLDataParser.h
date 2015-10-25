//
//  smsAPIXMLDataParser.h
//  tamilsms
//
//  Created by Mohan Kumar on 25/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface smsAPIXMLDataParser : NSXMLParser <NSXMLParserDelegate>

- (NSDictionary*) processedXMLResultDict;

@end
