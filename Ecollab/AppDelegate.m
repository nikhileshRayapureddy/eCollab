//
//  AppDelegate.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 10/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "DashboardViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // here you have to check if user logedin or not
    
//    UIPageControl *pageControl = [UIPageControl appearance];
//    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
//    pageControl.backgroundColor = [UIColor whiteColor];
 
    
    UIImage *navBarBackgroundImage = [UIImage imageNamed:@"navigationbarBg.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    
    ViewController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:loginController];
    self.window.rootViewController=navController;
    
    NSString *strLoggedIn = [[NSUserDefaults standardUserDefaults]objectForKey:@"ISLOGGEDIN"];
    if([strLoggedIn isEqualToString:@"1"])
    {
        NSString *strUserId = [[NSUserDefaults standardUserDefaults]objectForKey:@"USERLOGGEDINID"];
        [[[DetailsManager sharedManager]rID]setString:strUserId];
        
        NSMutableDictionary *dict = [[NSUserDefaults standardUserDefaults]objectForKey:@"UserData"];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"ISLOGGEDIN"];
        UIStoryboard *storyboard =
        [UIStoryboard storyboardWithName:@"Main"
                                  bundle:[NSBundle mainBundle]];
        DashboardViewController *DVCtrlObj = [storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
        DVCtrlObj.userData = dict;
        [navController pushViewController:DVCtrlObj animated:false];
    }
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    [[IQKeyboardManager sharedManager] setShouldShowTextFieldPlaceholder:YES];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(removeLoader) name:@"REMOVEHUDLOADER" object:nil];
    
    return YES;
}

-(void)removeLoader
{
    [EcollabLoader removeLoader];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
