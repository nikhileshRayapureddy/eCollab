//
//  EcollabLoader.m
//  Ecollab
//
//  Created by Kiran Kumar on 19/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "EcollabLoader.h"
static const CGFloat kPadding = 4.f;

@implementation EcollabLoader
@synthesize labelText;
@synthesize detailsLabelText;
@synthesize showBgImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupLabels];
        indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [indicator startAnimating];
        indicator.center = self.center;
        [self addSubview:indicator];
        [self layoutSubviews];
        
    }
    return self;
}

+ (EcollabLoader *)showLoaderAddedTo:(UIView *)view animated:(BOOL)animated withAnimationType:(AnimationType)animation {
    EcollabLoader *hud = [[EcollabLoader alloc] initWithView:view];
    hud.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.6];
    hud.tag = AppLoaderTag;
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSLog(@"Showing Loader");
    switch (animation) {
        case kAnimationTypeNormal:
        {
            break;
        }
        default:
            break;
    }
    
    [view addSubview:hud];
    [hud show:animated];
    return hud;
}

//to show loader for a particular view

+ (EcollabLoader *)loaderForView:(UIView *)view {
    Class hudClass = [EcollabLoader class];
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:hudClass]) {
            return (EcollabLoader *)subview;
        }
    }
    return nil;
}

+ (BOOL)hideLoaderForView:(UIView *)view animated:(BOOL)animated {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSLog(@"Hiding Loader");
    for (int i=0; i<3; i++) {
        
        EcollabLoader *hud = [EcollabLoader loaderForView:view];
        if (hud != nil) {
            //hud.removeFromSuperViewOnHide = YES;
            [hud done];
        }
    }
    return YES;
}
//To remove loader
- (void)done
{
    [self removeFromSuperview];
}

- (void)setupLabels {
    
    
    
    label = [[UILabel alloc] initWithFrame:self.bounds];
    label.adjustsFontSizeToFitWidth = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.opaque = NO;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.text = self.labelText;
    [self addSubview:label];
    
    detailsLabel = [[UILabel alloc] initWithFrame:self.bounds];
    detailsLabel.adjustsFontSizeToFitWidth = NO;
    detailsLabel.textAlignment = NSTextAlignmentCenter;
    detailsLabel.opaque = NO;
    detailsLabel.backgroundColor = [UIColor clearColor];
    detailsLabel.textColor = [UIColor whiteColor];
    detailsLabel.numberOfLines = 0;
    detailsLabel.text = self.detailsLabelText;
    [self addSubview:detailsLabel];
}

//to design the subviews layouts
- (void)layoutSubviews {
    
    // Entirely cover the parent view
    UIView *parent = self.superview;
    if (parent) {
        self.frame = parent.bounds;
    }
    CGRect bounds = self.bounds;
    
    // Determine the total widt and height needed
    CGFloat maxWidth = bounds.size.width - 4 * 1;
    CGSize totalSize = CGSizeZero;
    
    CGRect indicatorF = indicator.bounds;
    indicatorF.size.width = MIN(indicatorF.size.width, maxWidth);
    totalSize.width = MAX(totalSize.width, indicatorF.size.width);
    totalSize.height += indicatorF.size.height;
    
    CGSize labelSize = [labelText sizeWithFont:label.font];
    {
        labelSize = [labelText sizeWithAttributes:@{NSFontAttributeName:label.font}];
    }
    labelSize.width = MIN(labelSize.width, maxWidth);
    totalSize.width = MAX(totalSize.width, labelSize.width);
    totalSize.height += labelSize.height;
    if (labelSize.height > 0.f && indicatorF.size.height > 0.f) {
        totalSize.height += kPadding;
    }
    
    CGFloat remainingHeight = bounds.size.height - totalSize.height - kPadding - 4 * 1;
    CGSize maxSize = CGSizeMake(maxWidth, remainingHeight);
    CGSize detailsLabelSize = [detailsLabelText sizeWithFont:detailsLabel.font
                                           constrainedToSize:maxSize lineBreakMode:detailsLabel.lineBreakMode];
    
    {
        CGRect rect;
        rect = [detailsLabelText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:detailsLabel.font} context:nil];
        detailsLabelSize.width = ceilf(rect.size.width);
        detailsLabelSize.height = ceilf(rect.size.height);
    }
    
    totalSize.width = MAX(totalSize.width, detailsLabelSize.width);
    totalSize.height += detailsLabelSize.height;
    if (detailsLabelSize.height > 0.f && (indicatorF.size.height > 0.f || labelSize.height > 0.f)) {
        totalSize.height += kPadding;
    }
    
    totalSize.width += 2 * 1;
    totalSize.height += 2 * 1;
    float yOffset = 0;
    float xOffset = 0;
    // Position elements
    CGFloat yPos = roundf(((bounds.size.height - totalSize.height) / 2)) + 1 + yOffset;
    CGFloat xPos = xOffset;
    indicatorF.origin.y = yPos;
    indicatorF.origin.x = roundf((bounds.size.width - indicatorF.size.width) / 2) + xPos;
    indicator.frame = indicatorF;
    yPos += indicatorF.size.height;
    
    if (labelSize.height > 0.f && indicatorF.size.height > 0.f) {
        yPos += kPadding;
    }
    CGRect labelF;
    labelF.origin.y = yPos;
    labelF.origin.x = roundf((bounds.size.width - labelSize.width) / 2) + xPos;
    labelF.size = labelSize;
    label.frame = labelF;
    label.text = labelText;
    yPos += labelF.size.height;
    
    if (detailsLabelSize.height > 0.f && (indicatorF.size.height > 0.f || labelSize.height > 0.f)) {
        yPos += kPadding;
    }
    CGRect detailsLabelF;
    detailsLabelF.origin.y = yPos;
    detailsLabelF.origin.x = roundf((bounds.size.width - detailsLabelSize.width) / 2) + xPos;
    detailsLabelF.size = detailsLabelSize;
    detailsLabel.frame = detailsLabelF;
    detailsLabel.text = detailsLabelText;
    // Enforce minsize and quare rules
    //	if (square) {
    //		CGFloat max = MAX(totalSize.width, totalSize.height);
    //		if (max <= bounds.size.width - 2 * margin) {
    //			totalSize.width = max;
    //		}
    //		if (max <= bounds.size.height - 2 * margin) {
    //			totalSize.height = max;
    //		}
    //	}
    //	if (totalSize.width < minSize.width) {
    //		totalSize.width = minSize.width;
    //	}
    //	if (totalSize.height < minSize.height) {
    //		totalSize.height = minSize.height;
    //	}
    //
    //	self.size = totalSize;
}

-(void)show:(BOOL)animated
{
    [self setNeedsDisplay];
    
}
//Initialisation of Views
- (id)initWithView:(UIView *)view {
    NSAssert(view, @"View must not be nil.");
    id me = [self initWithFrame:view.bounds];
    // We need to take care of rotation ourselfs if we're adding the HUD to a window
    if ([view isKindOfClass:[UIWindow class]]) {
        [self setTransformForCurrentOrientation:NO];
    }
    return me;
}

//Manage the rotaion of the screen
- (void)setTransformForCurrentOrientation:(BOOL)animated {
    // Stay in sync with the superview
    if (self.superview) {
        self.bounds = self.superview.bounds;
        [self setNeedsDisplay];
    }
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat radians = 0;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        if (orientation == UIInterfaceOrientationLandscapeLeft) { radians = -(CGFloat)M_PI_2; }
        else { radians = (CGFloat)M_PI_2; }
        // Window coordinates differ!
        self.bounds = CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.width);
    } else {
        if (orientation == UIInterfaceOrientationPortraitUpsideDown) { radians = (CGFloat)M_PI; }
        else { radians = 0; }
    }
    rotationTransform = CGAffineTransformMakeRotation(radians);
    
    if (animated) {
        [UIView beginAnimations:nil context:nil];
    }
    [self setTransform:rotationTransform];
    if (animated) {
        [UIView commitAnimations];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
