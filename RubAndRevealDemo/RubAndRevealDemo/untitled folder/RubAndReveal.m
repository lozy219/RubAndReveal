//
//  RubAndReveal.m
//  RubAndRevealDemo
//
//  Created by Mingyu on 27/7/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

#import "RubAndReveal.h"

@interface RubAndReveal()

@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *frontImageView;

@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *frontImage;

@end

@implementation RubAndReveal

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)configureLayoutWithBackImage:(UIImage *)backImage frontImage:(UIImage *)frontImage {
    CGRect imageFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.backImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.frontImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.backImage = backImage;
    self.backImageView.image = self.backImage;
    self.frontImage = frontImage;
    self.frontImageView.image = self.frontImage;
    [self addSubview:self.backImageView];
    [self addSubview:self.frontImageView];
}

@end
