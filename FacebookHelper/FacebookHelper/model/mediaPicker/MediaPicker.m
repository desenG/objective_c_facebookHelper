//
//  MediaPicker.m
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-08.
//  Copyright © 2016 divecommunications. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MediaPicker.h"
@implementation MediaPicker

@synthesize pickedAsset,m_controller,pickedAssetURL;

- (id)initWithViewController:(UIViewController*) p_controller
{
    if( self = [super init] )
    {
        // Initialize your object here
    }
    m_controller=p_controller;
    return self;
}

-(void)loadAssetWithAssetType: (NSString*)assetType// movie-kUTTypeMovie image-kUTTypeImage
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
    {
    }else{
        [self startMediaBrowserFromViewController:m_controller usingDelegate:self assetType:assetType];
    }
}

- (BOOL) startMediaBrowserFromViewController: (UIViewController*) controller
                               usingDelegate: (id <UIImagePickerControllerDelegate,
                                               UINavigationControllerDelegate>) delegate
                                   assetType: (NSString*)assetType// movie-kUTTypeMovie image-kUTTypeImage
{
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: assetType, nil];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    
    mediaUI.delegate = delegate;
    
    [controller presentViewController: mediaUI animated: YES completion:nil];
    return YES;
}

// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    [m_controller dismissViewControllerAnimated:NO completion:nil];
    // Handle a movie capture
    if (CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeMovie, 0)
        == kCFCompareEqualTo) {
        NSLog(@"Captured is movie");
        pickedAssetURL=[info objectForKey:UIImagePickerControllerMediaURL];
        pickedAsset = [AVAsset assetWithURL:pickedAssetURL];
    }
    else if(CFStringCompare ((__bridge_retained CFStringRef) mediaType, kUTTypeImage, 0)== kCFCompareEqualTo)
    {
        NSLog(@"Captured is image");
        pickedAssetURL=[info objectForKey:UIImagePickerControllerReferenceURL];
        pickedAsset = [AVAsset assetWithURL:pickedAssetURL];
    }
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    
}
- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
    [m_controller dismissViewControllerAnimated:NO completion:nil];
}

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [m_controller dismissViewControllerAnimated:NO completion:nil];
}

@end