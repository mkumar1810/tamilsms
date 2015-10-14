//
//  smsRESTProxy.m
//  tamilsms
//
//  Created by Mohan Kumar on 03/10/15.
//  Copyright © 2015 arun benjamin. All rights reserved.
//

#import "smsRESTProxy.h"

@interface smsRESTProxy()<NSURLSessionDelegate, NSURLSessionDataDelegate>
{
    NSString *_responseType;
    //NSMutableData *_webData;
    NSMutableDictionary *_inputParms;
    GENERICCALLBACK _proxyReturnMethod;
}

//method to generate the data
- (void) generateData;
//showing alert message if needed to be implemented
- (void) showAlertMessage:(NSString*) p_dispMessage;
//returning error message.
- (void) returnErrorMessage:(NSString*) p_errMsg;

@end

@implementation smsRESTProxy


- (void) initDatawithAPIType:(NSString*) p_apiType andInputParams:(NSDictionary*) p_prmDict andReturnMethod:(GENERICCALLBACK) p_returnMethod
{
    _responseType = p_apiType;
    _proxyReturnMethod = p_returnMethod;
    _inputParms = [[NSMutableDictionary alloc] init];
    if (p_prmDict)
    {
        [_inputParms addEntriesFromDictionary:p_prmDict];
    }
    [self generateData];
}

- (void) generateData
{
    NSURLSessionConfiguration * l_defSessConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * l_theSession = [NSURLSession sessionWithConfiguration:l_defSessConfig delegate:self delegateQueue:nil];
    NSURL *l_url;
    NSMutableURLRequest *l_theRequest;
    NSString * l_requesttype;
    l_requesttype = @"GET";
    if ([_responseType isEqualToString:@"DATASYNC"]==YES)
    {
        NSString * l_urlquery = [NSString
                                 stringWithFormat:@"update=%ld&user=%ld&iupdate=%ld&iuser=%ld",
                                 [[_inputParms valueForKey:@"smsversion"] integerValue],
                                 [[_inputParms valueForKey:@"userversion"] integerValue],
                                 [[_inputParms valueForKey:@"ismsversion"] integerValue],
                                 [[_inputParms valueForKey:@"iuserversion"] integerValue]];
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@",MAIN_URL,@"ios-sms-apis",l_urlquery]];
    }
    else if ([_responseType isEqualToString:@"DATACHECK"]==YES)
    {
        NSString * l_urlquery = [NSString
                                 stringWithFormat:@"update=%ld&user=%ld&iupdate=%ld&iuser=%ld",
                                 [[_inputParms valueForKey:@"smsversion"] integerValue],
                                 [[_inputParms valueForKey:@"userversion"] integerValue],
                                 [[_inputParms valueForKey:@"ismsversion"] integerValue],
                                 [[_inputParms valueForKey:@"iuserversion"] integerValue]];
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@",MAIN_URL,@"ios-sms-api",l_urlquery]];
    }
    l_theRequest = [NSMutableURLRequest requestWithURL:l_url];
    [l_theRequest addValue: @"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [l_theRequest setHTTPMethod:l_requesttype];
    NSURLSessionDataTask * l_dataTask = [l_theSession dataTaskWithRequest:l_theRequest completionHandler:^(NSData * p_respData, NSURLResponse * p_response, NSError * p_error){
        [self urlSessionCompletedWith:p_respData andResponse:p_response andError:p_error];
    }];
    if(l_dataTask)
    {
        [l_dataTask resume];
        //_webData = [[NSMutableData data] init];
    }
    else
        [self returnErrorMessage:@"Error in Connection"];
}

- (void) showAlertMessage:(NSString*) p_dispMessage
{
    
    //need to be coded when there is need for showing some kind of alert message
}

- (void) returnErrorMessage:(NSString*) p_errMsg
{
    if (_proxyReturnMethod!=NULL)
        dispatch_async(dispatch_get_main_queue(), ^(){
            /*_proxyReturnMethod([NSJSONSerialization dataWithJSONObject:@{@"error":@"-1", @"errmsg":p_errMsg}
                                                               options:kNilOptions error:nil]);*/
            
            _proxyReturnMethod(@{@"error":@"-1", @"errmsg":p_errMsg});

        });
}

/*
 - (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
 {
 //[_webData setLength:0];
 completionHandler(NSURLSessionResponseAllow);
 }
 
 - (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
 {
 [_webData appendData:data];
 NSLog(@"%@", [[NSString alloc] initWithData:_webData encoding:NSUTF8StringEncoding]);
 }
 */


//json parsing
- (void) urlSessionCompletedWith:(NSData*) p_respData andResponse:(NSURLResponse*) p_response andError:(NSError*) p_error
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSError * l_restError = nil;
        id l_returndict = [NSJSONSerialization
                           JSONObjectWithData:p_respData
                           options:NSJSONReadingMutableLeaves
                           error:&l_restError];
        if (l_restError!=nil) {
            [self returnErrorMessage:[l_restError description]];
            return;
        }

        
        if (_proxyReturnMethod!=NULL)
        {
            //NSLog(@"responsetype %@ and inputparams %@", _responseType, _inputParms);
            _proxyReturnMethod(l_returndict);
        }
    });
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self returnErrorMessage:[error description]];
}

@end