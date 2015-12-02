//
//  AppDelegate.m
//  SearchExamples
//
//  Created by Richard Forsythe on 12/1/15.
//  Copyright © 2015 NoteStream. All rights reserved.
//

#import "AppDelegate.h"
@import CoreSpotlight;
@import MobileCoreServices;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUpCoreSpotlight];
    return YES;
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)activity restorationHandler:(void (^)(NSArray *))restorationHandler
{
    
    NSString * valueCSSearchableItemActionType;
    BOOL wasHandled = NO;
    
    if ([CSSearchableItemAttributeSet class]) //iOS 9
    {
        
        valueCSSearchableItemActionType = CSSearchableItemActionType;
        
    } else { // iOS 8 or earlier
        
        valueCSSearchableItemActionType = @"not supported";
    }
    
    if ([activity.activityType isEqual: valueCSSearchableItemActionType])
        //Clicked on spotlight search, item was created via CoreSpotlight API
    {
        
        //…handle the click here, we can assume iOS 9 from now on…
        NSString * activityIdentifier = [activity.userInfo valueForKey:CSSearchableItemActivityIdentifier];
        wasHandled = YES;
        NSLog(@"Continuing user activity %@", activityIdentifier);
        
    } else {
        
        //the app was launched via Handoff protocol
        //or with a Universal Link
    }
    
    return wasHandled;
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

-(void)setUpCoreSpotlight
{
    
    //Imaging for demo purposes that these items have been pulled from a server because they have been saved
    //to the user's personal bookmarks at some point -- perhaps on another device.
    
    CSSearchableItemAttributeSet * attributeSet = [[CSSearchableItemAttributeSet alloc]
                    initWithItemContentType:(NSString *)kUTTypeItem];
    
    attributeSet.displayName = @"A Christmas Carol";
    attributeSet.title = @"A Christmas Carol By Charles Dickens";
            //Sounds similar to displayName but is not displayed to user
    attributeSet.contentDescription = @"Who would dare to say “Bah! Humbug” after reading A Christmas Carol? Charles Dickens wrote the novella in just six weeks before it was first published on December 19 1843 but his morality tale about a bitter old miser named Ebenezer Scrooge lives on to this day as a reminder of the importance of the Christmas spirit.";
    attributeSet.keywords = @[@"A Christmas Carol", @"Charles Dickens", @"Victorian Literature"];
    UIImage *image = [UIImage imageNamed:@"CC-Cover"];
    NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    attributeSet.thumbnailData = imageData;
    
    CSSearchableItem *item1 = [[CSSearchableItem alloc]
                              initWithUniqueIdentifier:@"https://www.notestream.com/streams/564159e4e5c24"
                              domainIdentifier:@"notestream.com"
                              attributeSet:attributeSet];
    
    
    
    
    attributeSet = [[CSSearchableItemAttributeSet alloc]
                                                     initWithItemContentType:(NSString *)kUTTypeItem];
    
    attributeSet.displayName = @"How Do Enzymes Work?";
    attributeSet.title = @"How Do Enzymes Work? By Joseph Bennington-Castro";
    //Sounds similar to displayName but is not displayed to user
    attributeSet.contentDescription = @"Enzymes are biological molecules (typically proteins) that significantly speed up the rate of virtually all of the chemical reactions that take place within cells.";
    attributeSet.keywords = @[@"Enzymes", @"Science", @"Joseph Bennington-Castro"];
    image = [UIImage imageNamed:@"enzymes-cover"];
    imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    attributeSet.thumbnailData = imageData;
    
    CSSearchableItem *item2 = [[CSSearchableItem alloc]
                               initWithUniqueIdentifier:@"https://www.notestream.com/streams/5637b2c2a8f5e"
                               domainIdentifier:@"notestream.com"
                               attributeSet:attributeSet];
    
    
    
    
    attributeSet = [[CSSearchableItemAttributeSet alloc]
                                                      initWithItemContentType:(NSString *)kUTTypeItem];
    
    attributeSet.displayName = @"Why Does Our Balance Get Worse As We Age?";
    attributeSet.title = @"Why Does Our Balance Get Worse As We Age? By Dawn Skelton";
    //Sounds similar to displayName but is not displayed to user
    attributeSet.contentDescription = @"All of us have taken a tumble at some point in our lives. But as we grow older, the risks associated with falling over become greater: we lose physical strength and bone density, our sense of balance deteriorates and we take longer to recover from a fall. Alarmingly, this process begins around the age of 25. The reasons for this are varied and complex, but by understanding them better, we can find ways to mitigate the effects of old age.";
    attributeSet.keywords = @[@"Balance", @"Aging", @"health", @"Dawn Skelton"];
    image = [UIImage imageNamed:@"balance-cover"];
    imageData = [NSData dataWithData:UIImagePNGRepresentation(image)];
    attributeSet.thumbnailData = imageData;
    
    CSSearchableItem *item3 = [[CSSearchableItem alloc]
                               initWithUniqueIdentifier:@"https://www.notestream.com/streams/562944bd5a2b3"
                               domainIdentifier:@"notestream.com"
                               attributeSet:attributeSet];
    
    
    
    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item1, item2, item3]
                                                   completionHandler: ^(NSError * __nullable error) {
                                                       if (!error)
                                                           NSLog(@"Search item(s) journaled for indexing.");
                                                   }];
    
}

@end
