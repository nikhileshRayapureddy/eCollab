//
//  EcollabLoader.h
//  Ecollab
//
//  Created by Kiran Kumar on 19/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#define AppLoaderTag 543210
typedef enum kAnimationType
{
    kAnimationTypeNormal
}AnimationType
;
@class EcollabLoader;
@interface EcollabLoader : UIView
{
    UILabel *label;
    UILabel *detailsLabel;
    NSString *labelText;
    NSString *detailsLabelText;
    UIActivityIndicatorView *indicator;
    BOOL showBgImage;
    CGAffineTransform rotationTransform;
    
}
@property(nonatomic, assign) BOOL showBgImage;
@property(nonatomic, retain) NSString *labelText;
@property(nonatomic, retain) NSString *detailsLabelText;
//to show loader
//Parameter
//View to be added,animation type,bool variable to intimate whether to animate or not
//Result
//Loader
+ (EcollabLoader *)showLoaderAddedTo:(UIView *)view animated:(BOOL)animated withAnimationType:(AnimationType)animation;
//To show animation for the loader
//Parameter
//bool variable to intimate whether to animate or not
-(void)show:(BOOL)animated;
//To setup labels on loader
- (void)setupLabels;
//To hide the loader
//Parameter
//View to be added,animation type,bool variable to intimate whether to animate or not
//Result
//Yes to hide and No to don't hide
+ (BOOL)hideLoaderForView:(UIView *)view animated:(BOOL)animated;

@end
