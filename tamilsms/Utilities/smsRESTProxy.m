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
    NSString * l_messagebody,* l_requesttype, * l_msglength;
//    NSError * l_error;
    NSString * l_contentType;
    NSData * l_imagepassdata;
    l_requesttype = @"GET";
    l_contentType = @"text/plain; charset=utf-8";
    if ([_responseType isEqualToString:@"DATASYNC"]==YES)
    {
        NSString * l_urlquery = [NSString
                                 stringWithFormat:@"update=%ld&user=%ld&iupdate=%ld&iuser=%ld",
                                 [[_inputParms valueForKey:@"smsversion"] longValue],
                                 [[_inputParms valueForKey:@"userversion"] longValue],
                                 [[_inputParms valueForKey:@"ismsversion"] longValue],
                                 [[_inputParms valueForKey:@"iuserversion"] longValue]];
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@",MAIN_URL,DATA_SYNC_URL,l_urlquery]];
    }
    else if ([_responseType isEqualToString:@"DATACHECK"]==YES)
    {
        NSString * l_urlquery = [NSString
                                 stringWithFormat:@"update=%ld&user=%ld&iupdate=%ld&iuser=%ld",
                                 [[_inputParms valueForKey:@"smsversion"] longValue],
                                 [[_inputParms valueForKey:@"userversion"] longValue],
                                 [[_inputParms valueForKey:@"ismsversion"] longValue],
                                 [[_inputParms valueForKey:@"iuserversion"] longValue]];
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?user_details=0&%@",MAIN_URL,DATA_CHECK_URL,l_urlquery]];
    }
    else if ([_responseType isEqualToString:@"SIGNUPUSER"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?job=add&username=%@&password=%@&email=%@&mobileno=%@&location=%@toasturl=pushid",MAIN_URL,SIGNUP_USER,[_inputParms valueForKey:@"username"],[_inputParms valueForKey:@"password"],[_inputParms valueForKey:@"email"],[_inputParms valueForKey:@"mobileno"],[_inputParms valueForKey:@"location"]]];
    }
    else if ([_responseType isEqualToString:@"LOGINUSER"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?job=getid&username=%@&password=%@",MAIN_URL,SIGNUP_USER,[_inputParms valueForKey:@"username"],[_inputParms valueForKey:@"password"]]];
    }
    else if ([_responseType isEqualToString:@"TOP25_AUTHORS"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id=4",MAIN_URL,TOP25_AUTHORS]];
    } //
    else if ([_responseType isEqualToString:@"TOP25_AUTHORS"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id=4",MAIN_URL,TOP25_AUTHORS]];
    } //
    else if ([_responseType isEqualToString:@"TOP25_TXT_MSGS"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?user_id=%d&page=%d&own=0",MAIN_URL,TOP25_AUTHOR_RELATED_MSGS,[[_inputParms valueForKey:@"user_id"] intValue],[[_inputParms valueForKey:@"page"] intValue]]];
    }//TOP25_IMAGE_MSGS
    else if ([_responseType isEqualToString:@"LATEST_TXT_MSGS"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id=1&page=%d",MAIN_URL,LATEST_TEXT_MSGS,[[_inputParms valueForKey:@"page"]intValue]]];
    }
    else if ([_responseType isEqualToString:@"TOP_SHARED_TEXT_MSG"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id=3&page=%d",MAIN_URL,TOP_SHARED_TEXT_MSG,[[_inputParms valueForKey:@"page"]intValue]]];
    }
    else if ([_responseType isEqualToString:@"TOP_FAV_TEXT_MSG"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id=2&page=%d",MAIN_URL,TOP_SHARED_TEXT_MSG,[[_inputParms valueForKey:@"page"]intValue]]];
    }
    
    else if ([_responseType isEqualToString:@"TOP25_IMAGE_MSGS"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?user_id=%d&page=%d&own=4",MAIN_URL,TOP25_AUTHOR_RELATED_MSGS,[[_inputParms valueForKey:@"user_id"] intValue],[[_inputParms valueForKey:@"page"] intValue]]];
    }
    else if ([_responseType isEqualToString:@"LATEST_IMG_MSG"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id_img=1&page=%d",MAIN_URL,LATEST_IMG_MSG,[[_inputParms valueForKey:@"page"] intValue]]];
    }
    else if ([_responseType isEqualToString:@"TOP_SHARED_IMAG_MSG"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id_img=3&page=%d",MAIN_URL,LATEST_IMG_MSG,[[_inputParms valueForKey:@"page"] intValue]]];
    }
    else if ([_responseType isEqualToString:@"TOP_FAV_IMG_MSG"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?page_id_img=2&page=%d",MAIN_URL,LATEST_IMG_MSG,[[_inputParms valueForKey:@"page"] intValue]]];
    }
    else if ([_responseType isEqualToString:@"POSTTXTMSG"]==YES)
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?job=add&user_id=%ld&cat_id=%ld",MAIN_URL,POST_TXT_MSG,[[_inputParms valueForKey:@"user_id"] longValue],[[_inputParms valueForKey:@"cat_id"] longValue]]];
        l_requesttype = @"POST";
        l_messagebody = [NSString stringWithFormat:@"news_heading=%@",[_inputParms valueForKey:@"news_heading"]];
        l_contentType = @"application/x-www-form-urlencoded";
    }
    else if ([_responseType isEqualToString:@"POSTIMAGEMSG"]==YES)
    {
        NSString * l_newstorageid = [[NSUUID UUID] UUIDString];
        l_newstorageid = [l_newstorageid substringFromIndex:([l_newstorageid length]-12)];
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?add&user_id=%ld&cat_id=%ld",MAIN_URL,POST_IMAGE_MSG,[[_inputParms valueForKey:@"user_id"] longValue],[[_inputParms valueForKey:@"cat_id"] longValue]]];
        l_requesttype = @"POST";
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        l_contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        
        NSMutableData *body = [NSMutableData data];
         [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
         [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"news_image\"; filename=\"%@.jpg\"\r\n", l_newstorageid] dataUsingEncoding:NSUTF8StringEncoding]];
         [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
         [body appendData:[_inputParms valueForKey:@"image_data"]];
         [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        l_imagepassdata = [NSData dataWithData:body];
    }
    else if ([_responseType isEqualToString:@"LIKE_POST"])
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?item_id=%@",MAIN_URL,LIKE_ITEM_LOG,[[_inputParms valueForKey:@"item_id"] stringValue]]];
    }
    else if ([_responseType isEqualToString:@"SHARE_POST"])
    {
        l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@?item_id=%@",MAIN_URL,SHARE_ITEM_LOG,[[_inputParms valueForKey:@"item_id"] stringValue]]];
    }
    
    l_theRequest = [NSMutableURLRequest requestWithURL:l_url];
    [l_theRequest addValue:l_contentType  forHTTPHeaderField:@"Content-Type"];
    if ([_responseType isEqualToString:@"POSTIMAGEMSG"]==YES)
    {
        [l_theRequest setHTTPBody:l_imagepassdata];
    }
    else if ([l_requesttype isEqualToString:@"POST"] | [l_requesttype isEqualToString:@"PUT"])
    {
        l_msglength = [NSString stringWithFormat:@"%ld", (unsigned long)[[l_messagebody dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES] length]];
        [l_theRequest setValue:l_msglength forHTTPHeaderField:@"Content-Length"];
        [l_theRequest setHTTPBody:[l_messagebody dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES]];
    }
    
    l_theRequest = [NSMutableURLRequest requestWithURL:l_url];
    [l_theRequest addValue:l_contentType  forHTTPHeaderField:@"Content-Type"];
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
            
            if (_proxyReturnMethod!=NULL)
            {
                _proxyReturnMethod(@{@"error":@"-1", @"errmsg":p_errMsg});
            }
        });
}


//json parsing
- (void) urlSessionCompletedWith:(NSData*) p_respData andResponse:(NSURLResponse*) p_response andError:(NSError*) p_error
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSError * l_restError = nil;
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