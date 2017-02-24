//
//  UIButton+Block.h
//  LPTools
//
//  Created by lipeng on 15/10/24.
//  Copyright © 2015年 lpdev.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void (^ActionBlock)();

@interface UIButton (Block)

@property (readonly) NSMutableDictionary *event;

- (void)handleControlEvent:(UIControlEvents)controlEvent withBlock:(ActionBlock)action;

@end
