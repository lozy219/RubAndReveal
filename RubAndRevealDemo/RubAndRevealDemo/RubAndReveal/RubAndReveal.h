//
//  RubAndReveal.h
//  RubAndRevealDemo
//
//  Created by Mingyu on 27/7/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RubAndReveal : UIView

@property (nonatomic, strong) NSString *lineCap;
@property (nonatomic, strong) NSString *lineJoin;
@property (nonatomic, assign) CGFloat lineWidth;

- (void)configureLayoutWithBackImage:(UIImage *)backImage frontImage:(UIImage *)frontImage;
- (void)resetImage;

@end
