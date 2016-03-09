//
//  ViewController.m
//  FacebookHelper
//
//  Created by DesenGuo on 2016-03-06.
//

#import "ViewController.h"

@interface ViewController ()
{
    BOOL isSelectingAssetOne;
    MediaPicker* videoPicker;
    MediaPicker* imagePicker;
}

@end

@implementation ViewController

@synthesize btnFacebookLogin;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionFacebookLogin:(id)sender
{
    
    // Currently Logged in so log out
    if ([[FBCache alloc] init].getFBSDKAccessToken) {
        
        [btnFacebookLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btnFacebookLogin setTitle:@"LOGIN" forState:UIControlStateNormal];
        btnFacebookLogin.backgroundColor = [UIColor whiteColor];
        [[FacebookHelper sharedInstance] logoutWithFunctionBlock:^{
            
        }];
    }
    else
    {
        [[FacebookHelper sharedInstance] loginFromViewController:self withFunctionBlock:^{
            FBSDKAccessToken* newToken=[[FBCache alloc] init].getFBSDKAccessToken;
            if(newToken)
            {
                [btnFacebookLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [btnFacebookLogin setTitle:@"LOGOUT" forState:UIControlStateNormal];
                btnFacebookLogin.backgroundColor =[UIColor colorWithRed:249.0/255.0 green:080.0/255.0 blue:021.0/255.0 alpha:1.0];
            }
            else{
                [btnFacebookLogin setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [btnFacebookLogin setBackgroundColor:[UIColor whiteColor]];
                [btnFacebookLogin setTitle:@"LOGIN" forState:UIControlStateNormal];
            }
        }];
    }
}

- (IBAction)LoadVideoAsset:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
    {
    }else{
        videoPicker=[[MediaPicker alloc] initWithViewController:self];
        [videoPicker loadAssetWithAssetType:(NSString*)kUTTypeMovie];
    }
}

- (IBAction)LoadImageAsset:(id)sender{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
    {
    }else{
        imagePicker=[[MediaPicker alloc] initWithViewController:self];
        [imagePicker loadAssetWithAssetType:(NSString*)kUTTypeImage];
    }
}

- (IBAction)fbShareWithLink:(id)sender{

}

- (IBAction)fbShareWithLoadedVideo:(id)sender{
    if(videoPicker)
    {
        NSData *videoData = [NSData dataWithContentsOfURL:videoPicker.pickedAssetURL];
//        FBShareUtility* fbImageShare=[[FBShareUtility alloc]initWithTitle:@"" andDescription:@"" andPhoto:im];
//        [fbImageShare startGraphAction];
    }
    else{
        NSLog(@"load image first.");
    }
}

- (IBAction)fbShareWithLoadedImage:(id)sender{
    if(imagePicker)
    {
        UIImage *im = [UIImage imageWithData: [NSData dataWithContentsOfURL:imagePicker.pickedAssetURL]];
        FBShareUtility* fbImageShare=[[FBShareUtility alloc]initWithTitle:@"" andDescription:@"" andPhoto:im];
        [fbImageShare startGraphAction];
    }
    else{
        NSLog(@"load image first.");
    }
}

@end
