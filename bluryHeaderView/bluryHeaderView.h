//
//  bluryHeaderView.h
//  bluryHeaderView
//
//  Created by 谈Xx on 15/8/26.
//  Copyright (c) 2015年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "bluryView.h"
#import "MyAttributedStringBuilder.h"

@interface bluryHeaderView : UIView

/**
 *  模糊层 内部的view属性已设置，会更随父视图放大
 */
@property (nonatomic, strong) bluryView *bluryView;
/**
 *  按钮
 */
@property (nonatomic, strong) UIButton *btn;
/**
 *  主标题
 */
@property (nonatomic, strong) UILabel *mainLabel;
/**
 *  副标题
 */
@property (nonatomic, strong) UILabel *minorLabel;
/**
 *  折
 */
@property (nonatomic, strong) UILabel *discount;
/**
 *  向上拖动的时候 是否有减速 盖住的效果
 *  默认开启
 */
@property (nonatomic, assign) BOOL isCoverSlide;

/**
 *  构造方法
 *
 *  @param bluryImg 图片
 *  @param frame    位置
 *  @param blurytyp 发现后来设置type有问题，就创建的时候传了
 */
- (instancetype)initWithbluryImg:(UIImage *)bluryImg andFrame:(CGRect)frame andBluryType:(bluryType)blurytyp;

+ (instancetype)bluryWithbluryImg:(UIImage *)bluryImg andFrame:(CGRect)frame andBluryType:(bluryType)blurytyp;

/**
 *  监听table的滚动 改变自己的大小
 *
 *  @param offset <#offset description#>
 */
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset;

/**
 *  设置主文本的内容
 *
 *  @param title <#title description#>
 *  @param isneed <#isneed description#>
 */
- (void)setMainLabelTitle:(NSString *)title andIsNeedZhe:(BOOL)isneed;
/**
 *  设置副文本的内容
 *
 *  @param title <#title description#>
 */
- (void)setMinorLabelTitle:(NSString *)title;
/**
 *  设置按钮
 *
 *  @param title 文字
 *  @param color 颜色
 */
- (void)setBtnWithTitle:(NSString *)title andBgColor:(UIColor *)color;
@end
