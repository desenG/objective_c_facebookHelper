//
//  MediaPicker.h
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-08.
//  Copyright © 2016 divecommunications. All rights reserved.
//

#ifndef MediaPicker_h
#define MediaPicker_h


#endif /* MediaPicker_h */
@interface MediaPicker : NSObject <UIImagePickerControllerDelegate,UINavigationControllerDelegate,MPMediaPickerControllerDelegate>
{
    
}
@property(nonatomic,retain)AVAsset* pickedAsset;
@property(nonatomic,retain)NSURL * pickedAssetURL;
@property(nonatomic,retain)UIViewController* m_controller;
- (id)initWithViewController:(UIViewController*) p_controller;
-(void)loadAssetWithAssetType: (NSString*)assetType;// movie-kUTTypeMovie image-kUTTypeImage
@end