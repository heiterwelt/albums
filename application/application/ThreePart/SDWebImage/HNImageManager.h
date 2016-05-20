//
//  HNImageManager.h
//  application
//
//  Created by Linyou-IOS-1 on 16/5/20.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HNImageManager : NSObject

@property(nonatomic,strong)NSMutableArray *imageArray;

@property(nonatomic,strong)NSMutableArray *keyArray;
+(HNImageManager *)shareInterface;
@end
