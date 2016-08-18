//
//  CompundDBCustomView.m
//  Ecollab
//
//  Created by NIKHILESH on 18/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "CompundDBCustomView.h"

@implementation CompundDBCustomView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];

//        self = [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil] objectAtIndex:0];
        
    }
    self.frame = frame;
    return self;
}


@end
