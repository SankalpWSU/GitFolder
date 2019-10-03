//
//  ViewController.h
//  ObjectiveCProject
//
//  Created by MCS on 9/30/19.
//  Copyright © 2019 MCS. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (atomic, weak) NSString* theProperty;

// instance function starting by "-"
- (void)printHelloWorld;
// above line is equilent to func printHelloWorld() { }

// instance of class func we use "+" to start with
+ (void)printHello :(NSString*)input;

// - (NSString*)returnHello :(NSString*)firstInput :(NSString*)secondInput;

@end

