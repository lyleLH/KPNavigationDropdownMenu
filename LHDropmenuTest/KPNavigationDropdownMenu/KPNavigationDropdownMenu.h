//
//  KPNavigationDropdownMenuView.h
//  KPBusiness
//
//  Created by lyleKP on 2017/2/17.
//  Copyright © 2017年 KP. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonBlock)(UIButton *button);

extern  const NSUInteger kOrderListCategoryButtonTagOffset;

@interface KPNavigationDropdownMenu : UIButton

/**
 点击的菜单项按钮Block事件
 根据tag来区分按钮，实际的tag需要减掉偏移量kOrderListCategoryButtonTagOffset
 */
@property (nonatomic,copy) ButtonBlock categoryBtnClicked;

/**
 初始化方法

 @param navigationController 当前控制器的导航栏控制器
 @param titleAry 菜单名称数组
 */
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController andTitles:(NSArray*)titleAry;


- (void)show;

- (void)hide;


@end
