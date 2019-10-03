//
//  ViewController.m
//  ObjectiveCProject
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize theProperty;
// synthesize does the getters and the setters property for the variable


- (void)viewDidLoad {
    [super viewDidLoad];
    NSString*(^theBlock)(NSString*) = ^(NSString* firstInput) {
        return firstInput;
    };
    // Do any additional setup after loading the view.
    theBlock(@"hi");
}

- (void)printHelloWorld {
    NSLog(@"Hello World");
}

+ (void)printHello:(NSString *)input {
    NSLog(@"Hello %@", input);
}


@end
