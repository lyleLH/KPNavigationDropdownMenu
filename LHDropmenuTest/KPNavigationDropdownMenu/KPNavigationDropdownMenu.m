//
//  KPNavigationDropdownMenuView.m
//  KPBusiness
//
//  Created by lyleKP on 2017/2/17.
//  Copyright © 2017年 KP. All rights reserved.
//

#import "KPNavigationDropdownMenu.h"
#import "UIButton+Block.h"
#import "NSString+LHSizeOfString.h"

#define kWindowHeight CGRectGetHeight([UIScreen mainScreen].applicationFrame)
#define kWindowWidth CGRectGetWidth([UIScreen mainScreen].bounds)

const NSUInteger kOrderListCategoryButtonTagOffset = 999;

@interface KPNavigationDropdownMenu ()

@property (nonatomic, weak) UINavigationController *navigationController;

@property (nonatomic, strong) UIView *menuContentView;
@property (nonatomic,assign)CGFloat  categoryButtonHeight;

@property (nonatomic, strong) UIView *menuBackgroundView;

@property (nonatomic,strong)NSArray * titleArray;

@property (nonatomic,assign)CGFloat arrowPadding;

@property (nonatomic,assign)NSTimeInterval animationDuration;
@property (nonatomic,strong)UIImage * arrowImage;

@property (nonatomic,strong)UIColor *titleColor;
@property (nonatomic,strong)UIFont *titleFont;

@end

@implementation KPNavigationDropdownMenu

- (instancetype)initWithNavigationController:(UINavigationController *)navigationController andTitles:(NSArray*)titleAry{
    self = [KPNavigationDropdownMenu buttonWithType:UIButtonTypeCustom];
    if (self) {
        self.frame = navigationController.navigationBar.frame;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.navigationController = navigationController;
        self.titleArray = titleAry;
        [self setTitle:self.titleArray.firstObject forState:UIControlStateNormal];
        [self addTarget:self action:@selector(menuAction:) forControlEvents:UIControlEventTouchUpInside];
        [self setUpSubviews];
    }
    return self;
}


#pragma mark - Public method

- (void)setUpSubviews {
    [self.titleLabel setFont:self.titleFont];
    [self setTitleColor:self.titleColor forState:UIControlStateNormal];
    [self setImage:self.arrowImage forState:UIControlStateNormal];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -CGRectGetWidth(self.imageView.frame), 0.0, CGRectGetWidth(self.imageView.frame) + self.arrowPadding)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, CGRectGetWidth(self.titleLabel.frame) + self.arrowPadding, 0.0, -CGRectGetWidth(self.titleLabel.frame))];
    CGRect menuBackgroundViewFrame = [UIScreen mainScreen].bounds;
    menuBackgroundViewFrame.origin.y = 64;
    menuBackgroundViewFrame.size.height = [UIScreen mainScreen].bounds.size.height - 64;
    self.menuBackgroundView.frame = menuBackgroundViewFrame;
    CGFloat contentHeight = 0.0f;
    NSUInteger col  = 0;
    if(self.titleArray.count<=3) {
        col = 1;
    }else {
        if(self.titleArray.count%3==0){
            col = self.titleArray.count/3;
        }else{
            col = self.titleArray.count/3+1;
        }
    }
    contentHeight = col * self.categoryButtonHeight + 15 *3;
    self.menuContentView.frame = CGRectMake(0, -((self.titleArray.count/3)* self.categoryButtonHeight + 15 *4), [UIScreen mainScreen].bounds.size.width,contentHeight);
    [self.menuBackgroundView addSubview:self.menuContentView];
    
}


- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self.menuBackgroundView];
    
    CGRect menuContentViewFrame = self.menuContentView.frame;
    menuContentViewFrame.origin.y = -((self.titleArray.count/3) * self.categoryButtonHeight + 15 *3);
    self.menuContentView.frame = menuContentViewFrame;
    self.selected = YES;
    [UIView animateWithDuration:self.animationDuration * 1.5 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:kNilOptions animations:^{
//        NSLog(@"show begin -- menuContentView frame :%@",NSStringFromCGRect(self.menuContentView.frame));
        CGRect menuContentViewFrame = self.menuContentView.frame;
        menuContentViewFrame.origin.y = 0.0f;
        self.menuContentView.frame = menuContentViewFrame;
        self.menuBackgroundView.alpha = 1.0;
//        NSLog(@"show finished -- menuContentView frame :%@",NSStringFromCGRect(self.menuContentView.frame));
    } completion:nil];
}

- (void)hide {
    self.selected = NO;
    [UIView animateWithDuration:self.animationDuration animations:^{
        CGRect menuContentViewFrame = self.menuContentView.frame;
        menuContentViewFrame.origin.y = -((self.titleArray.count/3) * self.categoryButtonHeight+ 15 *3);
        self.menuContentView.frame = menuContentViewFrame;
        self.menuBackgroundView.alpha = 0.0;
//        NSLog(@"hide finished -- menuContentView frame :%@",NSStringFromCGRect(self.menuContentView.frame));
    } completion:^(BOOL finished) {
        [self.menuBackgroundView removeFromSuperview];
    }];
}

#pragma mark - Event Response

- (void)menuAction:(KPNavigationDropdownMenu *)sender {
    self.isSelected?[self hide]:[self show];
}

#pragma mark - Property method

- (UIView *)menuContentView {
    if (_menuContentView == nil) {
        _menuContentView = [[UIView alloc] initWithFrame:self.menuBackgroundView.bounds];
        _menuContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        _menuContentView.backgroundColor = [UIColor whiteColor];
        for(NSInteger index = 0 ; index < self.titleArray.count; index ++) {
            UIButton * categoryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            if(index == 0){
                [categoryBtn setTitleColor:[self colorWithHex:0xff6c00] forState:UIControlStateNormal];
                categoryBtn.layer.borderColor = [self colorWithHex:0xff6c00].CGColor;
            }else{
                [categoryBtn setTitleColor:[self colorWithHex:0x9f9f9f] forState:UIControlStateNormal];
                categoryBtn.layer.borderColor = [self colorWithHex:0x9f9f9f].CGColor;
            }
            
            [categoryBtn setTitle:self.titleArray[index] forState:UIControlStateNormal];
            
            categoryBtn.titleLabel.font  = [UIFont systemFontOfSize:15];
            categoryBtn.tag = index+kOrderListCategoryButtonTagOffset;
            categoryBtn.layer.borderWidth  = 0.5f;
            [categoryBtn setFrame:CGRectMake((index%3)*((kWindowWidth-60)/3+15)+15 , (index/3)*(35+15)+15 , (kWindowWidth-60)/3, 35)];
            [categoryBtn handleControlEvent:UIControlEventTouchUpInside withBlock:^{
                [self setTitle:[self.titleArray objectAtIndex:index] forState:UIControlStateNormal];
                NSUInteger selectedTag = index+kOrderListCategoryButtonTagOffset;
                UIButton * btnNew = (UIButton *)[self.menuContentView viewWithTag:selectedTag];
                [btnNew setTitleColor:[self colorWithHex:0xff6c00] forState:UIControlStateNormal];
                btnNew.layer.borderColor = [self colorWithHex:0xff6c00].CGColor;
                
                for(NSInteger notNewIndex = 0; notNewIndex <self.titleArray.count;notNewIndex ++) {
                    if(notNewIndex+kOrderListCategoryButtonTagOffset != selectedTag ){
                        UIButton * notNew = (UIButton *)[self.menuContentView viewWithTag:notNewIndex +kOrderListCategoryButtonTagOffset];
                        [notNew setTitleColor:[self colorWithHex:0x9f9f9f] forState:UIControlStateNormal];
                        notNew.layer.borderColor = [self colorWithHex:0x9f9f9f].CGColor;
                    }
                }
                
                if(_categoryBtnClicked){
                    NSInteger index =  categoryBtn.tag - kOrderListCategoryButtonTagOffset;
                    NSString * title = @"";
                    title = [self.titleArray objectAtIndex:index];
                    [self setTitle:title forState:UIControlStateNormal];
                    
                    //                    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0, -CGRectGetWidth(self.imageView.frame), 0.0, CGRectGetWidth(self.imageView.frame) + self.arrowPadding)];
                    CGSize titleSize  = [title lh_sizeOfStrWithFont:[UIFont systemFontOfSize:18]];
                    [self setImageEdgeInsets:UIEdgeInsetsMake(0.0, titleSize.width + self.arrowPadding, 0.0, -titleSize.width)];
                    _categoryBtnClicked (categoryBtn);
                }
                [self hide];
            }];
            [_menuContentView addSubview:categoryBtn];
            
        }
        [self.menuBackgroundView addSubview:self.menuContentView];
    }
    return _menuContentView;
}

- (UIView *)menuBackgroundView {
    if (_menuBackgroundView == nil) {
        _menuBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        _menuBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _menuBackgroundView.clipsToBounds = YES;
        _menuBackgroundView.alpha = 0.0;
        _menuBackgroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
    }
    return _menuBackgroundView;
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:self.animationDuration animations:^{
        if (selected) {
            self.imageView.transform = CGAffineTransformMakeRotation(M_PI);
        } else {
            self.imageView.transform = CGAffineTransformMakeRotation(0.0);
        }
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
}

- (UIFont *)titleFont {
    return [UIFont systemFontOfSize:18];
}

- (UIColor *)titleColor {
    return [self colorWithHex:0x333333];
}

- (UIImage *)arrowImage {
    return [UIImage imageNamed:@"direction_down"];
}
- (CGFloat)categoryButtonHeight {
    return 35.0f;
}
- (CGFloat)arrowPadding {
      return 8.0f;
}

- (NSTimeInterval)animationDuration {
    return 0.25;

}

- (UIColor *)colorWithHex:(int)hexValue alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
                           green:((float)((hexValue & 0xFF00) >> 8))/255.0
                            blue:((float)(hexValue & 0xFF))/255.0
                           alpha:alpha];
}

- (UIColor *)colorWithHex:(int)hexValue {
    return [self colorWithHex:hexValue alpha:1.0];
}


@end
