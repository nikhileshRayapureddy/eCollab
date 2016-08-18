

#import <Foundation/Foundation.h>

@interface ServiceInterface : NSObject <NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate>{
    NSMutableData *receivedData;
    
    NSObject *theDelegate;
    SEL theSuccessMethod;
    SEL theFailureMethod;
}

@property(strong, nonatomic)NSObject *theDelegate;
@property(nonatomic)SEL theSuccessMethod;
@property(nonatomic)SEL theFailureMethod;

-(void)startWithRequest:(NSMutableURLRequest *)request;
-(void)startWithURL:(NSURL *)url;

@end

