//
//  RootViewController.h
//  application
//
//  Created by Linyou-IOS-1 on 16/5/11.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "UIButton+WebCache.h"

#import "application-Swift.h"



#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
- (IBAction)addPictures:(id)sender;

- (IBAction)addLiterature:(id)sender;

@end

