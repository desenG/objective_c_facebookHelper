//
//  FacebookUtility.h
//
//  Created by DesenGuo on 2016-02-04.
//
#import "FBCache.h"
#import "TypeDefinition.h"
#import "SBJson.h"
#import "FBContact.h"

#ifndef FacebookUtility_h
#define FacebookUtility_h


#endif /* FacebookUtility_h */
@interface FacebookUtility:NSObject
+ (instancetype)sharedInstance;
-(void)loginFromViewController:(UIViewController*)viewController
             withFunctionBlock:(FunctionBlock)block;
-(void)logoutWithFunctionBlock:(FunctionBlock)block;
-(void)updateFBFriensWithToken:(FBSDKAccessToken*) token
                 FunctionBlock:(FunctionBlock)block;
@end