//
//  RecipeZoomViewController.m
//  NestleDesserts
//
//  Created by Anand Kumar on 3/29/14.
//  Copyright (c) 2014 WinItSoftware. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()

@end

@implementation ZoomViewController
@synthesize imgRecipeView,scrImgVw,strImgUrl;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self)
    {
        self.view.frame=frame;
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.imgRecipeView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrImgVw.delegate=self;
    self.scrImgVw.minimumZoomScale=1.0f;
    self.scrImgVw.maximumZoomScale=6.0f;
    self.scrImgVw.zoomScale=1.0;
    self.scrImgVw.frame=CGRectMake(0 ,0, 320, self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Zoom In/Out

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // Return the view that we want to zoom
    self.scrImgVw.frame=CGRectMake(0 ,0, self.view.frame.size.width, self.view.frame.size.height);

    return self.imgRecipeView;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // The scroll view has zoomed, so we need to re-center the contents
    [self centerScrollViewContents];
}
- (void)centerScrollViewContents {
    CGSize boundsSize = self.scrImgVw.bounds.size;
    CGRect contentsFrame = self.imgRecipeView.frame;
    
    if (contentsFrame.size.width < boundsSize.width)
    {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    }
    else
    {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imgRecipeView.frame = contentsFrame;
}

-(void)dealloc
{
    if(self.scrImgVw){
        [self.scrImgVw removeFromSuperview];
        self.scrImgVw=nil;
    }
    if(self.imgRecipeView){
        [self.imgRecipeView removeFromSuperview];
        self.imgRecipeView=nil;
    }
    ;
}
@end
