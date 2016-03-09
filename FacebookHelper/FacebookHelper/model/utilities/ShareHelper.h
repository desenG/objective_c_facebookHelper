//
//  DiveShareHelper.h
//
//  Created by DesenGuo on 2016-03-08.
//

#ifndef ShareHelper_h
#define ShareHelper_h


#endif /* ShareHelper_h */
@interface ShareHelper : NSObject<UIDocumentInteractionControllerDelegate>
+(void)shareFromViewController: (UIViewController*)target
withTextObject:(NSString *)textObject
                  andURLString:(NSString *)urlString;
-(void)shareFromViewController: (UIViewController*)target
                      withPath: (NSString *)path;

@end