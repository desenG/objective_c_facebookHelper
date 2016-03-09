//
//  FBShareUtility.m
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-07.
//  Copyright © 2016 divecommunications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBShareUtility.h"

@implementation FBShareUtility
{
    NSString *_mealTitle;
    FBSDKMessageDialog *_messageDialog;
    UIImage *_photo;
    int _sendAsMessageButtonIndex;
    FBSDKShareAPI *_shareAPI;
    FBSDKShareDialog *_shareDialog;
}

- (void)dealloc
{
    _shareAPI.delegate = nil;
    _shareDialog.delegate = nil;
    _messageDialog.delegate = nil;
}

#pragma mark - Share with uploading photo
- (instancetype)initWithTitle:(NSString *)title
               andDescription:(NSString*)description
                     andPhoto:(UIImage *)photo
{
    if ((self = [super init])) {
        FBSDKShareOpenGraphContent *shareContent = [FBShareUtility contentForSharingWithTitle:title andDescription:description andPhoto:photo];
        
        _shareAPI = [[FBSDKShareAPI alloc] init];
        _shareAPI.delegate = self;
        _shareAPI.shareContent = shareContent;
        
        _shareDialog = [[FBSDKShareDialog alloc] init];
        _shareDialog.delegate = self;
        _shareDialog.shouldFailOnDataError = YES;
        _shareDialog.shareContent = shareContent;
        
        _messageDialog = [[FBSDKMessageDialog alloc] init];
        _messageDialog.delegate = self;
        _messageDialog.shouldFailOnDataError = YES;
        _messageDialog.shareContent = shareContent;
    }
    return self;
}

+ (FBSDKShareOpenGraphContent *)contentForSharingWithTitle:(NSString*)title
                                            andDescription:(NSString*)description
                                                  andPhoto:(UIImage *)photo
{
    title=(title)?title:@"default title";
    description=(description)?description:@"default description";
    NSString *previewPropertyName = [@"dive: " stringByAppendingString:title];
    
    
    NSDictionary *objectProperties = @{
                                       @"og:type" : [@"dive: " stringByAppendingString:title],
                                       @"og:title": title,
                                       @"og:description" : [@"Description " stringByAppendingString:description],
                                       };
    id object = [FBSDKShareOpenGraphObject objectWithProperties:objectProperties];
    
    
    FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
    action.actionType = [@"dive: " stringByAppendingString:title];
    [action setObject:object forKey:previewPropertyName];
    if (photo) {
        [action setArray:@[[FBSDKSharePhoto photoWithImage:[FBShareUtility normalizeImage:photo] userGenerated:YES]] forKey:@"og:image"];
    }
    
    FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
    content.action = action;
    content.previewPropertyName = previewPropertyName;
    return content;
}

+ (UIImage *)normalizeImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    
    CGImageRef imgRef = image.CGImage;
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    CGSize imageSize = bounds.size;
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    
    switch (orient) {
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        default:
            // image is not auto-rotated by the photo picker, so whatever the user
            // sees is what they expect to get. No modification necessary
            transform = CGAffineTransformIdentity;
            break;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ((image.imageOrientation == UIImageOrientationDown) ||
        (image.imageOrientation == UIImageOrientationRight) ||
        (image.imageOrientation == UIImageOrientationUp)) {
        // flip the coordinate space upside down
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

#pragma mark - Share with uploading video(not working in this version)
- (instancetype)initWithTitle:(NSString *)title
               andDescription:(NSString*)description
                     andVideo:(NSURL *)videoURL
{
    if ((self = [super init])) {
        FBSDKShareOpenGraphContent *shareContent = [FBShareUtility contentForSharingWithTitle:title andDescription:description andVideo:videoURL];
        
        _shareAPI = [[FBSDKShareAPI alloc] init];
        _shareAPI.delegate = self;
        _shareAPI.shareContent = shareContent;
        
        _shareDialog = [[FBSDKShareDialog alloc] init];
        _shareDialog.delegate = self;
        _shareDialog.shouldFailOnDataError = YES;
        _shareDialog.shareContent = shareContent;
        
        _messageDialog = [[FBSDKMessageDialog alloc] init];
        _messageDialog.delegate = self;
        _messageDialog.shouldFailOnDataError = YES;
        _messageDialog.shareContent = shareContent;
    }
    return self;
}

+ (FBSDKShareOpenGraphContent *)contentForSharingWithTitle:(NSString*)title
                                            andDescription:(NSString*)description
                                                  andVideo:(NSURL *)videoURL
{
    title=(title)?title:@"default title";
    description=(description)?description:@"default description";
    NSString *previewPropertyName = [@"dive: " stringByAppendingString:title];
    
    
    NSDictionary *objectProperties = @{
                                       @"og:type" : [@"dive: " stringByAppendingString:title],
                                       @"og:title": title,
                                       @"og:description" : [@"Delicious " stringByAppendingString:description],
                                       };
    id object = [FBSDKShareOpenGraphObject objectWithProperties:objectProperties];
    
    
    FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
    action.actionType = [@"dive: " stringByAppendingString:title];
    [action setObject:object forKey:previewPropertyName];
    if (videoURL) {
        [action setArray:@[[FBSDKShareVideo videoWithVideoURL:videoURL]] forKey:@"og:video"];
    }
    
    FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
    content.action = action;
    content.previewPropertyName = previewPropertyName;
    return content;
}

#pragma mark - Share with urlString
- (instancetype)initWithTitle:(NSString *)title
               andDescription:(NSString*)description
                 andURLString:(NSString *)urlString
        andFromViewController:(UIViewController*)target
{
    if ((self = [super init])) {
        FBSDKShareLinkContent *shareContent = [FBShareUtility contentForSharingWithTitle:title andDescription:description andURLString:urlString];
        
        _shareAPI = [[FBSDKShareAPI alloc] init];
        _shareAPI.delegate = self;
        _shareAPI.shareContent = shareContent;
        
        _shareDialog = [[FBSDKShareDialog alloc] init];
        _shareDialog.delegate = self;
        _shareDialog.shouldFailOnDataError = YES;
        _shareDialog.shareContent = shareContent;
        
        _messageDialog = [[FBSDKMessageDialog alloc] init];
        _messageDialog.delegate = self;
        _messageDialog.shouldFailOnDataError = YES;
        _messageDialog.shareContent = shareContent;
        
        if(target)
        {
            _shareDialog.fromViewController = target;
        }
    }
    return self;
}

+ (FBSDKShareLinkContent *)contentForSharingWithTitle:(NSString*)title
                                       andDescription:(NSString*)description
                                         andURLString: (NSString*) urlString
{
    FBSDKShareLinkContent *content = [FBShareUtility getLinkShareContentWithURLString:urlString andContentTitle:title];
    
    return content;
}

+ (FBSDKShareLinkContent *)getLinkShareContentWithURLString: (NSString*) urlString
                                            andContentTitle:(NSString*)contentTitle
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = [NSURL URLWithString:urlString];
    content.contentTitle = contentTitle;
    return content;
}

+ (void)postToFacebookFromViewController:(UIViewController*)target
                         withInitialText:(NSString *)initialText
                            andURLString:(NSString *)urlString
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *facebookSheet = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeFacebook];
        [facebookSheet setInitialText:initialText];
        [facebookSheet addURL:[NSURL URLWithString:urlString]];
        [facebookSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultCancelled:
                    NSLog(@"Post Canceled");
                    break;
                case SLComposeViewControllerResultDone:
                    NSLog(@"Post Sucessful");
                    break;
                    
                default:
                    break;
            }
        }];
        [target presentViewController:facebookSheet animated:YES completion:nil];
    }
}

- (void)start
{
    [self.delegate shareUtilityWillShare:self];
    [_shareDialog show];
}


- (void)startGraphAction
{
    [self _postOpenGraphAction];
}

- (void)_postOpenGraphAction
{
    NSString *const publish_actions = @"publish_actions";
    if ([[FBSDKAccessToken currentAccessToken] hasGranted:publish_actions]) {
        [self.delegate shareUtilityWillShare:self];
        [_shareAPI share];
    } else {
        [[[FBSDKLoginManager alloc] init]
         logInWithPublishPermissions:@[publish_actions]
         fromViewController:nil
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             if ([result.grantedPermissions containsObject:publish_actions]) {
                 [self.delegate shareUtilityWillShare:self];
                 [_shareAPI share];
             } else {
                 // This would be a nice place to tell the user why publishing
                 // is valuable.
                 [_delegate shareUtility:self didFailWithError:nil];
             }
         }];
    }
}

- (void)startUploadWithVideoPath:(NSString*)videoFilePath
                        andTitle:(NSString*)title
                        andDescription:(NSString*)description
{
    NSLog(@"Facebook - startUpload");
    NSData *videoData = [NSData dataWithContentsOfFile:videoFilePath];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   videoData, @"sample.mp4",
                                   @"video/quicktime", @"contentType",
                                   title, @"title",
                                   description, @"description",
                                   nil];
    [[Facebook new] requestWithGraphPath:@"me/videos"
                              andParams:params
                          andHttpMethod:@"POST"
                            andDelegate:self];
    
}
#pragma mark FBRequestDelegate
- (void)request:(FFBRequest *)request didLoad:(id)result {
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
        NSLog(@"IT IS ARRAY");
    }
    NSLog(@"Result of API call: %@", result);
    NSObject *rObj = result;
    NSString *vid = [rObj valueForKey:@"id"];
    NSLog(@"Result id: %@", vid );
    NSURL *url = [NSURL URLWithString: [ NSString stringWithFormat:@"https://www.facebook.com/video.php?v=%@",vid ]];
}

- (void)request:(FFBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Failed with error: %@", [error localizedDescription]);
    NSLog(@"Err details: %@", [error description]);
}

- (void)request:(FFBRequest *)request didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"start response");
    NSLog(@"%@",response);
}

- (void)request:(FFBRequest *)request didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite{
    NSLog(@"Uploading:%ld/%ld",(long)totalBytesWritten,(long)totalBytesExpectedToWrite);
}

#pragma mark - FBSDKSharingDelegate
- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results {
    [_delegate shareUtilityDidCompleteShare:self];
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error {
    [_delegate shareUtility:self didFailWithError:error];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer {
    [_delegate shareUtility:self didFailWithError:nil];
}

@end
