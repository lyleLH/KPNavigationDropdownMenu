//
//  NSString+LHSizeOfString.h
//  KPShop
//
//  Created by lyleKP on 15/12/2.
//  Copyright © 2015年 kuparts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface NSString (LHSizeOfString)

- (CGSize)lh_sizeOfStrWithFont:(UIFont*)font;
- (float)lh_heightForStrAtSomeWidt:(CGFloat)width
                          WithFont:(UIFont*)font;
@end
