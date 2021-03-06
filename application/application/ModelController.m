//
//  ModelController.m
//  application
//
//  Created by Linyou-IOS-1 on 16/5/11.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import "ModelController.h"
#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


@interface ModelController ()

@property (readonly, strong, nonatomic) NSArray *pageData;
@property(nonatomic,strong)NSArray *imagarr;
@end

@implementation ModelController

- (instancetype)init {
    self = [super init];
    if (self) {
        // Create the data model.
        //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //_pageData = [[dateFormatter monthSymbols] copy];
       
     //   [self addObserver:self forKeyPath:@"self.imagarr.count" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];

    }
    return self;
}



//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([keyPath isEqual:@"self.imagarr.count"]) {
//        NSLog(@"%@",change);
//    }
//}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard {
    // Return the data view controller for the given index.
    if (([[HNImageManager shareInterface].imageArray count] == 0) || (index >= [[HNImageManager shareInterface].imageArray count])) {
        return nil;
    }

    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
   // dataViewController.dataObject = [HNImageManager shareInterface].imageArray[index];
    dataViewController.image=[HNImageManager shareInterface].imageArray[index];
    
    NSLog(@"imagename:\n%@imagearray index:\n%lu",dataViewController.image.description,(unsigned long)index);
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController {
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    
    return [[HNImageManager shareInterface].imageArray indexOfObject:viewController.image];
}

#pragma mark - Page View Controller Data Source
//
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if (viewController.navigationController.navigationBar.isHidden==NO) {
        [viewController.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
      if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (viewController.navigationController.navigationBar.isHidden==NO) {
        [viewController.navigationController setNavigationBarHidden:YES animated:YES];
        
    }
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [[HNImageManager shareInterface].imageArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
