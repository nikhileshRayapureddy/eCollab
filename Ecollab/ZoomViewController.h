//
//  RecipeZoomViewController.h
//  NestleDesserts
//
//  Created by Anand Kumar on 3/29/14.
//  Copyright (c) 2014 WinItSoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrImgVw;
@property (strong, nonatomic) IBOutlet UIImageView *imgRecipeView;

@property (strong, nonatomic) IBOutlet NSString *strImgUrl;

@property (assign, nonatomic) int height;
@property (assign, nonatomic) int width;
- (id)initWithFrame:(CGRect)frame;

@end
