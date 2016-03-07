//
//  FacebookHelper.m
//
//  Created by DesenGuo on 2016-02-22.
//

#import "FacebookHelper.h"
static FacebookHelper *_sharedInstance;

@implementation FacebookHelper

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [FacebookHelper new];
    });
    return _sharedInstance;
}

-(void)loginFromViewController:(UIViewController*)viewController
             withFunctionBlock:(FunctionBlock)block
{
        [[FacebookUtility sharedInstance] loginFromViewController:viewController withFunctionBlock:^{
            FBSDKAccessToken* newToken=[[FBCache alloc] init].getFBSDKAccessToken;

            if(newToken)
            {
                //do something here for app, such as save token string [newToken tokenString] to caches
                
                NSDictionary* newProfile=[[FBCache alloc] init].getFBSDKProfile;
                NSString* fbid=[newProfile objectForKey:@"id"];
                NSString* fbname=[newProfile objectForKey:@"name"];
                
                if(fbid != nil && fbid.length > 0)
                {
                }
                if(fbname != nil && fbname.length > 0)
                {
                }
            }
            else{

            }
            block();
        }];
}

-(void)updateFBFriendsFromViewController:(UIViewController*)viewController
                       withFunctionBlock:(FunctionBlock)block
{
    FBSDKAccessToken* newToken=[[FBCache alloc] init].getFBSDKAccessToken;
    if(!newToken)
    {
        [self loginFromViewController:viewController withFunctionBlock:^{
            block();
        }];
    }
    else{
        [[FacebookUtility sharedInstance] updateFBFriensWithToken:newToken FunctionBlock:^{
            block();
        }];
    }
}

-(void)logoutWithFunctionBlock:(FunctionBlock)block
{
    [[FacebookUtility sharedInstance] logoutWithFunctionBlock:^{
        //Do something here
        
        block();
    }];
}
@end

