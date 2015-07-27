//
//  RubAndReveal.m
//  RubAndRevealDemo
//
//  Created by Mingyu on 27/7/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

#import "RubAndReveal.h"

@interface RubAndReveal()

@property (nonatomic, strong) CALayer *backImageLayer;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *frontImageView;

@property (nonatomic, strong) UIImage *backImage;
@property (nonatomic, strong) UIImage *frontImage;

@property (nonatomic, strong) CAShapeLayer *eraseLayer;
@property (nonatomic, assign) CGMutablePathRef eraseStroke;

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
    self.backImageLayer = [[CALayer alloc] init];
    self.backImageLayer.frame = imageFrame;
    self.backImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.frontImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.backImage = backImage;
    self.backImageLayer.contents = (__bridge id)(self.backImage.CGImage);
    self.frontImage = frontImage;
    self.frontImageView.image = self.frontImage;
    [self addSubview:self.frontImageView];
    [self addSubview:self.backImageView];
    [self.backImageView.layer addSublayer:self.backImageLayer];
    
    self.eraseLayer = [[CAShapeLayer alloc] init];
    self.eraseLayer.fillColor = nil;
    self.eraseLayer.strokeColor = [[UIColor blackColor] CGColor];
    self.eraseLayer.frame = self.frontImageView.frame;
    self.eraseLayer.lineCap = kCALineCapRound;
    self.eraseLayer.lineJoin = kCALineJoinBevel;
    self.eraseLayer.lineWidth = 40;
    
    [self.layer addSublayer:self.eraseLayer];
    self.backImageLayer.mask = self.eraseLayer;
    
    self.eraseStroke = CGPathCreateMutable();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPathMoveToPoint(self.eraseStroke, nil, touchPoint.x, touchPoint.y);
    self.eraseLayer.path = CGPathCreateMutableCopy(self.eraseStroke);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPathAddLineToPoint(self.eraseStroke, nil, touchPoint.x, touchPoint.y);
    self.eraseLayer.path = CGPathCreateMutableCopy(self.eraseStroke);
}

@end
