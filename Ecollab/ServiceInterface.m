

#import "ServiceInterface.h"

@implementation ServiceInterface

@synthesize theDelegate, theSuccessMethod, theFailureMethod;
- (NSURLSession *)createSession
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    return defaultSession;
}
-(void)startWithRequest:(NSMutableURLRequest *)request {
    
    @try {
        //request timeoutInterval
        NSURLSessionDataTask * dataTask = [[self createSession] dataTaskWithRequest:request];
        [dataTask resume];
    }
    @catch (NSException *exception) {
        //[gApp ShowAlertWithCode:21];
    }
    @finally {
        
    }
    
}

-(void)startWithURL:(NSURL *)url {
    
    NSLog(@"Request URL : %@",url.absoluteString);
    @try {
        NSURLSessionDataTask * dataTask = [[self createSession] dataTaskWithURL:url];
        [dataTask resume];
    }
    @catch (NSException *exception) {
        //[gApp ShowAlertWithCode:21];
    }
    @finally {
        
    }
}

#pragma mark -
#pragma mark Service request methods

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSLog(@"### handler 1");
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    int responseStatusCode = [httpResponse statusCode];
    NSLog(@"value %d",responseStatusCode);
    receivedData=nil;
    receivedData=[[NSMutableData alloc] init];
    [receivedData setLength:0];
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        NSLog(@"Download is Succesfull");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
         [theDelegate performSelector:theSuccessMethod withObject:receivedData];
#pragma clang diagnostic pop
        
    }
    else{
        NSLog(@"Error %@",[error userInfo]);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"REMOVEHUDLOADER" object:nil];
        NSString *errorMessage = [error localizedDescription];
        [theDelegate performSelector:theFailureMethod withObject:errorMessage];
#pragma clang diagnostic pop
        
    }
    
    NSString *errorMessage = [error localizedDescription];
#if TARGET_IPHONE_SIMULATOR
    NSLog(@"Error:%@", errorMessage);
#endif
    
}

@end