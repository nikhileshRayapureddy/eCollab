//
//  DetailsManager.m
//  CSPayments
//
//  Created by Nikhil Challagulla on 9/3/13.
//  Copyright (c) 2013 Competent Systems. All rights reserved.
//

#import "DetailsManager.h"
//#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
@implementation DetailsManager
@synthesize view_token,rID;

+ (id)sharedManager {
    static DetailsManager *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}


- (id)init {
    if (self = [super init]) {
        // here is initialization of shared variables
        view_token =[NSMutableString stringWithFormat:@""];
        rID = [NSMutableString stringWithFormat:@""];
    }
    return self;
}
// Email validation
-(BOOL) validEmail:(NSString*) emailString {
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc] initWithPattern:regExPattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailString options:0 range:NSMakeRange(0, [emailString length])];
   
    if (regExMatches == 0) {
        return NO;
    } else
        return YES;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
