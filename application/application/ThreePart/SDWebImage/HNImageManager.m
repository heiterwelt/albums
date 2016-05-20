//
//  HNImageManager.m
//  application
//
//  Created by Linyou-IOS-1 on 16/5/20.
//  Copyright © 2016年 Linyou-IOS-1. All rights reserved.
//

#import "HNImageManager.h"
#import "SDImageCache.h"
@implementation HNImageManager
+(HNImageManager *)shareInterface{
    static HNImageManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[HNImageManager alloc]init];
    });
    return manager;
}


-(NSMutableArray *)keyArray
{
    if (!_keyArray) {
        _keyArray=[NSMutableArray array];
        
    }
    return _keyArray;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray=[NSMutableArray array];
         NSArray *arr=[NSArray arrayWithObjects:@"one",@"two",@"three",@"four",@"five",@"six",@"seven",@"eight",@"nine",@"ten",@"one",@"two", nil ];
       // for (NSString *name in arr) {
            
         //   UIImage *image=[UIImage imageNamed:name];
         //   [_imageArray addObject:image];
            
            NSInteger NUMBER=[[SDImageCache sharedImageCache] getDiskCount];
            if (NUMBER==0) {
                if (arr.count>=1) {
                    for (int i=1; i<arr.count+1; i++) {
                        NSString *key=[NSString stringWithFormat:@"image_%d",i];
                        UIImage *image=[UIImage imageNamed:arr[i-1]];
                        
                        [[SDImageCache sharedImageCache] storeImage:image forKey:key];
                        [self.imageArray addObject:image];
                        [self.keyArray addObject:key];
                    }
                    
                }
                
            }else{
               // NSMutableArray *arr=[NSMutableArray array];
                NSInteger getnum=[[SDImageCache sharedImageCache] getDiskCount];
                for (NSInteger n=1; n<getnum+1; n++) {
                    NSString *keyget=[NSString stringWithFormat:@"image_%ld",n];
                    
                    UIImage *image=[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:keyget];
                    if (image) {
                        [self.imageArray addObject:image];
                        [self.keyArray addObject:keyget];
                    }
                    
                    
                }
                

            }

            
     
           }
    return _imageArray;
}


@end
