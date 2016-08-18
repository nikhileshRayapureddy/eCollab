//
//  DetailsManager.h
//  CSPayments
//
//  Created by Nikhil Challagulla on 9/3/13.
//  Copyright (c) 2013 Competent Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DetailsManager : NSObject
@property (nonatomic, retain) NSMutableString *view_token,*rID;
+ (id)sharedManager;
// method declaration
-(BOOL) validEmail:(NSString*) emailString;
@end
