//
//  RootViewController.m
//  application
//
//  Created by Linyou-IOS-1 on 16/5/11.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import "RootViewController.h"
#import "ModelController.h"
#import "DataViewController.h"
#import "SDImageCache.h"
@interface RootViewController ()
{
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    BOOL _isSelectOriginalPhoto;
    
}

@property (nonatomic , strong) NSMutableArray *assets;


@property (readonly, strong, nonatomic) ModelController *modelController;

@property(nonatomic,strong)UISwipeGestureRecognizer *downgesture;
@end

@implementation RootViewController

@synthesize modelController = _modelController;
- (NSMutableArray *)assets{
    if (!_assets) {
        _assets = [NSMutableArray array];
    }
    return _assets;
}






- (void)viewDidLoad {
    [super viewDidLoad];
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;

    DataViewController *startingViewController = [self.modelController viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];

    self.pageViewController.dataSource = self.modelController;

    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];

    // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    //self.pageViewController.view.frame = pageViewRect;

    [self.pageViewController didMoveToParentViewController:self];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    if (self.navigationController.navigationBar.isHidden==YES) {
         NSLog(@"hhhhhhhhhhhhhhhhhhh");
    }
   
    self.downgesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipedown)];
    self.downgesture.direction=UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.downgesture];
    
    [self.pageViewController.view addGestureRecognizer:self.downgesture];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 九宫格创建ScrollView
 

}

-(void)swipedown
{
    if (self.navigationController.navigationBar.isHidden==YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ModelController *)modelController {
    // Return the model controller object, creating it if necessary.
    // In more complex implementations, the model controller may be passed to the view controller.
    if (!_modelController) {
        _modelController = [[ModelController alloc] init];
    }
    return _modelController;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - UIPageViewController delegate methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    
    if (self.navigationController.navigationBar.isHidden==NO) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    if (UIInterfaceOrientationIsPortrait(orientation) || ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)) {
        // In portrait orientation or on iPhone: Set the spine position to "min" and the page view controller's view controllers array to contain just one view controller. Setting the spine position to 'UIPageViewControllerSpineLocationMid' in landscape orientation sets the doubleSided property to YES, so set it to NO here.
        
        UIViewController *currentViewController = self.pageViewController.viewControllers[0];
        NSArray *viewControllers = @[currentViewController];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
        
        self.pageViewController.doubleSided = NO;
        return UIPageViewControllerSpineLocationMin;
    }

    // In landscape orientation: Set set the spine location to "mid" and the page view controller's view controllers array to contain two view controllers. If the current page is even, set it to contain the current and next view controllers; if it is odd, set the array to contain the previous and current view controllers.
    DataViewController *currentViewController = self.pageViewController.viewControllers[0];
    NSArray *viewControllers = nil;

    NSUInteger indexOfCurrentViewController = [self.modelController indexOfViewController:currentViewController];
    if (indexOfCurrentViewController == 0 || indexOfCurrentViewController % 2 == 0) {
        UIViewController *nextViewController = [self.modelController pageViewController:self.pageViewController viewControllerAfterViewController:currentViewController];
        viewControllers = @[currentViewController, nextViewController];
    } else {
        UIViewController *previousViewController = [self.modelController pageViewController:self.pageViewController viewControllerBeforeViewController:currentViewController];
        viewControllers = @[previousViewController, currentViewController];
    }
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];


    return UIPageViewControllerSpineLocationMid;
}

- (IBAction)addPictures:(id)sender {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:nil];
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    imagePickerVc.selectedAssets = _selectedAssets; // optional, 可选的
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        

        //保存
        NSInteger NUMBER=[[SDImageCache sharedImageCache] getDiskCount];
        if (NUMBER==0) {
            if (photos.count>=1) {
                for (int i=1; i<photos.count+1; i++) {
                    NSString *key=[NSString stringWithFormat:@"image_%d",i];
                    UIImage *image=photos[i-1];
                    
                    [[SDImageCache sharedImageCache] storeImage:image forKey:key];
                }

            }
        }
        
        
        if (NUMBER>0) {
            if (photos.count>=1) {
                for (NSInteger i=NUMBER+1; i<NUMBER+photos.count+1; i++) {
                    NSString *key=[NSString stringWithFormat:@"image_%ld",(long)i];
                    UIImage *image=photos[i-1];
                    
                    [[SDImageCache sharedImageCache] storeImage:image forKey:key];
                }
                
            }
        }
        
        
        //提取
        

        NSMutableArray *arr=[NSMutableArray array];
        NSInteger getnum=[[SDImageCache sharedImageCache] getDiskCount];
        for (NSInteger n=1; n<getnum+1; n++) {
            NSString *keyget=[NSString stringWithFormat:@"image_%ld",n];
            
            UIImage *image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:keyget];
            [arr addObject:image];
            
        }
        
        
        NSLog(@"%@",arr);
        
    }];
    
    // Set the appearance
    // 在这里设置imagePickerVc的外观
     imagePickerVc.navigationBar.barTintColor = [UIColor brownColor];
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    
    // Set allow picking video & photo & originalPhoto or not
    // 设置是否可以选择视频/图片/原图
    // imagePickerVc.allowPickingVideo = NO;
    // imagePickerVc.allowPickingImage = NO;
    // imagePickerVc.allowPickingOriginalPhoto = NO;
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];


}

- (IBAction)addLiterature:(id)sender {
}
@end
