//
//  FacebookHelper.h
//
//  Created by DesenGuo on 2016-02-22.
//
#import "AppDelegate.h"
#import "FacebookUtility.h"
#import "TypeDefinition.h"

#ifndef FacebookHelper_h
#define FacebookHelper_h


#endif /* FacebookHelper_h */
@interface FacebookHelper : NSObject
+ (instancetype)sharedInstance;
-(void)logoutWithFunctionBlock:(FunctionBlock)block;
-(void)loginFromViewController:(UIViewController*)viewController
             withFunctionBlock:(FunctionBlock)block;
-(void)updateFBFriendsFromViewController:(UIViewController*)viewController
                       withFunctionBlock:(FunctionBlock)block;
@end