//
//  smsAPIXMLDataParser.m
//  tamilsms
//
//  Created by Mohan Kumar on 25/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsAPIXMLDataParser.h"

@interface smsAPIXMLDataParser()
{
    NSMutableString * _parseElement, * _parseValue;
    NSMutableDictionary * _resultDict;
}

@end

@implementation smsAPIXMLDataParser

- (instancetype)initWithData:(NSData *)data
{
    self = [super initWithData:data];
    if (self) {
        //
        self.delegate = self;
        _resultDict = [[NSMutableDictionary alloc] init];
        _parseElement = [[NSMutableString alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict
{
    [_parseElement setString:elementName];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName
{
    [_parseElement setString:@""];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([_parseElement isEqualToString:@""]==NO)
        [_resultDict setValue:string forKey:_parseElement];
}

- (NSDictionary*) processedXMLResultDict
{
    return _resultDict;
}

@end
