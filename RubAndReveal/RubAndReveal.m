//
//  RubAndReveal.m
//  RubAndReveal
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

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinBevel;
        self.lineWidth = 40;
    }
    
    return self;
}

- (void)configureLayoutWithBackImage:(UIImage *)backImage frontImage:(UIImage *)frontImage {
    CGRect imageFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.backImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.frontImageView = [[UIImageView alloc] initWithFrame:imageFrame];
    self.backImage = backImage;
    self.frontImage = frontImage;

    CALayer *backImageLayer = [[CALayer alloc] init];
    backImageLayer.frame = imageFrame;
    backImageLayer.contents = (__bridge id)(self.backImage.CGImage);
    self.backImageLayer = backImageLayer;
    
    self.frontImageView.image = frontImage;
    
    [self addSubview:self.frontImageView];
    [self addSubview:self.backImageView];
    [self.backImageView.layer addSublayer:backImageLayer];
    
    CAShapeLayer *eraseLayer = [[CAShapeLayer alloc] init];
    eraseLayer.fillColor = nil;
    eraseLayer.strokeColor = [[UIColor blackColor] CGColor];
    eraseLayer.frame = imageFrame;
    eraseLayer.lineCap = self.lineCap;
    eraseLayer.lineJoin = self.lineJoin;
    eraseLayer.lineWidth = self.lineWidth;
    
    self.eraseLayer = eraseLayer;
    
    [self.layer addSublayer:self.eraseLayer];
    self.backImageLayer.mask = self.eraseLayer;
    
    self.eraseStroke = CGPathCreateMutable();
}

- (void)resetImage {
    self.eraseStroke = CGPathCreateMutable();
    self.eraseLayer.path = CGPathCreateMutable();
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPathMoveToPoint(self.eraseStroke, nil, touchPoint.x, touchPoint.y);
    self.eraseLayer.path = CGPathCreateMutableCopy(self.eraseStroke);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(rubbingStart)]) {
        [self.delegate rubbingStart];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    CGPathAddLineToPoint(self.eraseStroke, nil, touchPoint.x, touchPoint.y);
    self.eraseLayer.path = CGPathCreateMutableCopy(self.eraseStroke);
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rubbingEnd)]) {
        [self.delegate rubbingEnd];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rubbingEnd)]) {
        [self.delegate rubbingEnd];
    }
}

@end
