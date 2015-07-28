//
//  ViewController.m
//  RubAndRevealDemo
//
//  Created by Mingyu on 27/7/15.
//  Copyright (c) 2015 Echx. All rights reserved.
//

#import "ViewController.h"
#import "RubAndReveal.h"

@interface ViewController ()

@property (nonatomic, strong) RubAndReveal *demoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Create a rub and reveal view
    self.demoView = [[RubAndReveal alloc] init];
    RubAndReveal *demoView = self.demoView;
    
    // Configure the layout
    [demoView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:demoView];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[demoView(244)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(demoView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[demoView(200)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(demoView)]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:demoView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:demoView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [self.demoView setCenter: self.view.center];
    
    [self.view layoutSubviews];
    
    // Configure the properties of the view
    self.demoView.lineWidth = 35;
    
    // And call this method to set up the images
    [self.demoView configureLayoutWithBackImage:[UIImage imageNamed:@"xi"]
                                     frontImage:[UIImage imageNamed:@"jiang"]];
}

- (IBAction)reset:(id)sender {
    // Reset the image
    [self.demoView resetImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
