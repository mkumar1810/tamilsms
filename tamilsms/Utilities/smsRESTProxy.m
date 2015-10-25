//
//  smsRESTProxy.m
//  tamilsms
//
//  Created by Mohan Kumar on 03/10/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsRESTProxy.h"

@interface smsRESTProxy()<NSURLSessionDelegate, NSURLSessionDataDelegate>
{
    NSString *_responseType;
    //NSMutableData *_webData;
    NSMutableDictionary *_inputParms;
    GENERICCALLBACK _proxyReturnMethod;
    NSURLSession * _theSession;
}

//method to generate the data
- (void) generateData;
//showing alert message if needed to be implemented
- (void) showAlertMessage:(NSString*) p_dispMessage;
//returning error message.
- (void) returnErrorMessage:(NSString*) p_errMsg;

@end

@implementation smsRESTProxy

static NSURLSessionConfiguration * _defSessConfig;

- (void) initDatawithAPIType:(NSString*) p_apiType andInputParams:(NSDictionary*) p_prmDict andReturnMethod:(GENERICCALLBACK) p_returnMethod
{
    if (!_defSessConfig)
    {
        _defSessConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    _theSession = [NSURLSession sessionWithConfiguration:_defSessConfig delegate:self delegateQueue:nil];
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
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?user_details=0&%@",MAIN_URL,@"ios-api",l_urlquery]];
    }
    l_theRequest = [NSMutableURLRequest requestWithURL:l_url];
    [l_theRequest addValue: @"text/plain; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [l_theRequest setHTTPMethod:l_requesttype];
    NSURLSessionDataTask * l_dataTask = [_theSession dataTaskWithRequest:l_theRequest completionHandler:^(NSData * p_respData, NSURLResponse * p_response, NSError * p_error){
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


//json parsing
- (void) urlSessionCompletedWith:(NSData*) p_respData andResponse:(NSURLResponse*) p_response andError:(NSError*) p_error
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSError * l_restError = nil;
        /*NSLog(@"the received is %@",[[NSString alloc] initWithData:p_respData encoding:NSUTF8StringEncoding]);
        id l_returndict = [NSJSONSerialization
                           JSONObjectWithData:p_respData
                           options:NSJSONReadingMutableLeaves
                           error:&l_restError];*/
        [_theSession invalidateAndCancel];
        if (l_restError!=nil)
        {
            [self returnErrorMessage:[l_restError description]];
            return;
        }
        if (_proxyReturnMethod!=NULL)
        {
            //NSLog(@"responsetype %@ and inputparams %@", _responseType, _inputParms);
            //_proxyReturnMethod(l_returndict);
            _proxyReturnMethod(p_respData);
        }
    });
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    [self returnErrorMessage:[error description]];
}

@end