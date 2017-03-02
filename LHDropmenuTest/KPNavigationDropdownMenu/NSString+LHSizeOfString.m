//
//  NSString+LHSizeOfString.m
//  KPShop
//
//  Created by lyleKP on 15/12/2.
//  Copyright © 2015年 kuparts. All rights reserved.
//

#import "NSString+LHSizeOfString.h"

@implementation NSString (LHSizeOfString)


- (CGSize)lh_sizeOfStrWithFont:(UIFont*)font  {
 
    CGSize size ;
     size = [self sizeWithAttributes:@{ NSFontAttributeName:font}];
    
    return size;
}


- (float)lh_heightForStrAtSomeWidt:(CGFloat)width
                 WithFont:(UIFont*)font
{
#if 0
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    return rect.size.height;

#endif
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    return  ceilf(size.height);
    
    
}

@end
