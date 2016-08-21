//
//  SideMenuCustomView.m
//  Ecollab
//
//  Created by NIKHILESH on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "SideMenuCustomView.h"

@implementation SideMenuCustomView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    }
    self.frame = frame;
    return self;
}


@end
