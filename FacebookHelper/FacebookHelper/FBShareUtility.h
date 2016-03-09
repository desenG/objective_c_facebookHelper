//
//  FBShareUtility.h
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-07.
//  Copyright © 2016 divecommunications. All rights reserved.
//
#import "Facebook.h"
#import <Social/Social.h>
#ifndef FBShareUtility_h
#define FBShareUtility_h


#endif /* FBShareUtility_h */

@protocol FBShareUtilityDelegate;

@interface FBShareUtility : NSObject <UIActionSheetDelegate, FBSDKSharingDelegate,FBRequestDelegate>

@property (nonatomic, weak) UIViewController<FBShareUtilityDelegate> *delegate;

- (instancetype)initWithTitle:(NSString *)title
               andDescription:(NSString*)description
                     andPhoto:(UIImage *)photo;

- (instancetype)initWithTitle:(NSString *)title
               andDescription:(NSString*)description
                     andVideo:(NSURL *)videoURL;
- (instancetype)initWithTitle:(NSString *)title
               andDescription:(NSString*)description
                 andURLString:(NSString *)urlString
        andFromViewController:(UIViewController*)target;
+ (FBSDKShareLinkContent *)contentForSharingWithTitle:(NSString*)title
                                       andDescription:(NSString*)description
                                         andURLString: (NSString*) urlString;

- (void)start;
- (void)startGraphAction;

@end

@protocol FBShareUtilityDelegate

- (void)shareUtility:(FBShareUtility *)shareUtility didFailWithError:(NSError *)error;
- (void)shareUtilityWillShare:(FBShareUtility *)shareUtility;
- (void)shareUtilityDidCompleteShare:(FBShareUtility *)shareUtility;
- (void)shareUtilityUserShouldLogin:(FBShareUtility *)shareUtility;

@end