//
//  smsAsyncImageFetch.m
//  tamilsms
//
//  Created by Mohan Kumar on 23/09/15.
//  Copyright © 2015 Kuttyveni Computing Center. All rights reserved.
//

#import "smsAsyncImageFetch.h"
#import <objc/objc-sync.h>

@interface smsAsyncImageFetch()<NSURLSessionDelegate, NSURLSessionDataDelegate>
{
    //NSMutableData *_webData;
    DICTIONARYCALLBACK _proxyReturnMethod;
    //BOOL _returnArray;
    NSString * _fileName, * _tmpDirectory, /** _fileNameOnly,*/ * _localfilename;
}

@end

@implementation smsAsyncImageFetch

- (void) initDatawithFileName:(NSString*) p_fileName andReturnMethod:(DICTIONARYCALLBACK) p_returnCB
{
    _proxyReturnMethod = p_returnCB;
    _fileName = p_fileName;
    _tmpDirectory = NSTemporaryDirectory();
    /*NSArray * l_filecomponenets = [_fileName componentsSeparatedByString:@"/"];
    _fileNameOnly = [l_filecomponenets objectAtIndex:([l_filecomponenets count]-1)];*/
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self checkIfExistsOrGenerate];
    });
}

- (void) initWithFileNameDelete:(NSString*) p_fileName
{
    NSError * l_error = nil;
    _fileName = p_fileName;
    _tmpDirectory = NSTemporaryDirectory();
    /*NSArray * l_filecomponenets = [_fileName componentsSeparatedByString:@"/"];
    _fileNameOnly = [l_filecomponenets objectAtIndex:([l_filecomponenets count]-1)];*/
    _localfilename = [_tmpDirectory
                      stringByAppendingPathComponent:_fileName];
    NSFileManager * l_fileManager = [NSFileManager defaultManager];
    if ([l_fileManager fileExistsAtPath:_localfilename]==YES)
    {
        [l_fileManager removeItemAtPath:_localfilename error:&l_error];
    }
}

- (void) generateData
{
    NSURLSessionConfiguration * l_defSessConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * l_theSession = [NSURLSession sessionWithConfiguration:l_defSessConfig delegate:self delegateQueue:nil];
    NSURL *l_url;
    NSMutableURLRequest *l_theRequest;
    //NSURLConnection *l_theConnection;
    NSString * l_requesttype;
    l_url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",MAIN_IMAGES_URL,_fileName]];
    l_theRequest = [NSMutableURLRequest requestWithURL:l_url];
    l_requesttype = @"GET";
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

- (void) checkIfExistsOrGenerate
{
    _localfilename = [_tmpDirectory
                      stringByAppendingPathComponent:_fileName];
    NSFileManager * l_fileManager = [NSFileManager defaultManager];
    if ([l_fileManager fileExistsAtPath:_localfilename]==NO)
    {
        [self generateData];
    }
    else
    {
        _proxyReturnMethod(@{@"error":@"0", @"filename":_localfilename,@"linkname":_fileName});
    }
}

- (void) urlSessionCompletedWith:(NSData*) p_respData andResponse:(NSURLResponse*) p_response andError:(NSError*) p_error
{
    dispatch_async(dispatch_get_main_queue(), ^(){
        NSError * l_error = nil;
        @try
        {
            NSFileManager * l_fileManager = [NSFileManager defaultManager];
            if ([l_fileManager fileExistsAtPath:_localfilename]==NO)
            {
                NSDictionary * l_webdata = (NSDictionary*) [NSJSONSerialization JSONObjectWithData:p_respData options:NSJSONReadingMutableLeaves error:&l_error];
                if (!l_webdata)
                {
                    [p_respData writeToFile:_localfilename options:NSDataWritingAtomic error:&l_error];
                    if (_proxyReturnMethod!=NULL)
                    {
                        _proxyReturnMethod(@{@"error":@"0", @"filename":_localfilename,@"linkname":_fileName});
                        return;
                    }
                }
                else
                    NSLog(@"the web error is %@ ", l_webdata);
            }
            else
            {
                if (_proxyReturnMethod!=NULL)
                {
                    _proxyReturnMethod(@{@"error":@"0", @"filename":_localfilename,@"linkname":_fileName});
                    return;
                }
            }
            if (l_error)
            {
                [self returnErrorMessage:@"error during save"];
            }
            _proxyReturnMethod(@{@"error":@"0",@"linkname":_fileName});
        }
        @catch (NSException *exception) {
            [self returnErrorMessage:[exception description]];
        }
        //_proxyReturnMethod(p_respData);
    });
    /*NSError * l_restError = nil;
     @try {
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
     _proxyReturnMethod(l_returndict);
     }
     }
     @catch (NSException *exception) {
     [self returnErrorMessage:[exception description]];
     }*/
}


- (void) returnErrorMessage:(NSString*) p_errMsg
{
    if (_proxyReturnMethod!=NULL)
    {
        _proxyReturnMethod(@{@"error":@"-1", @"errmsg":p_errMsg});
    }
}

/*- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}


- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError * l_error = nil;
    @try
    {
        //[_webData writeToFile:_localfilename atomically:YES];
        //dispatch_semaphore_t l_semphore = dispatch_semaphore_create(<#long value#>)
        NSFileManager * l_fileManager = [NSFileManager defaultManager];
        if ([l_fileManager fileExistsAtPath:_localfilename]==NO)
        {
            NSDictionary * l_webdata = (NSDictionary*) [NSJSONSerialization JSONObjectWithData:_webData options:NSJSONReadingMutableLeaves error:&l_error];
            if (!l_webdata)
            {
                [_webData writeToFile:_localfilename options:NSDataWritingAtomic error:&l_error];
                if (_proxyReturnMethod!=NULL)
                {
                    _proxyReturnMethod(@{@"error":@"0", @"filename":_localfilename,@"linkname":_fileName});
                    return;
                }
            }
            else
                NSLog(@"the web error is %@ ", l_webdata);
        }
        else
        {
            if (_proxyReturnMethod!=NULL)
            {
                _proxyReturnMethod(@{@"error":@"0", @"filename":_localfilename,@"linkname":_fileName});
                return;
            }
        }
        if (l_error)
        {
            [self returnErrorMessage:@"error during save"];
        }
        _proxyReturnMethod(@{@"error":@"0",@"linkname":_fileName});
    }
    @catch (NSException *exception) {
        [self returnErrorMessage:[exception description]];
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self returnErrorMessage:[error description]];
}
*/


@end

