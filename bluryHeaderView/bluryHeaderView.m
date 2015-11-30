//
//  bluryHeaderView.m
//  bluryHeaderView
//
//  Created by 谈Xx on 15/8/26.
//  Copyright (c) 2015年 谈Xx. All rights reserved.
//

#import "bluryHeaderView.h"
#import "UIImage+ImageEffects.h"

static CGFloat kParallaxDeltaFactor = 0.7f;
static CGFloat kMaxTitleAlphaOffset = 100.0f;
static CGFloat kLabelPaddingDist = 8.0f;

#define DisCountNoHeight 70 // 折扣的高度
#define DisMargin 5  // 间距
#define MinorMargin 20  // 主文本 副文本间距
#define DisSize 20  // “折”的size
#define MinorHeight 15  // 副文本的高度
#define BtnMarginW 13  // 按钮左右间距
#define BtnMarginH 13  // 按钮上间距
#define BtnHight 40  // 按钮的高度

#define kDefaultHeaderFrame CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
@implementation bluryHeaderView

//@synthesize mainLabel = _mainLabel;

- (instancetype)initWithbluryImg:(UIImage *)bluryImg andFrame:(CGRect)frame andBluryType:(bluryType)blurytype
{
    if (self = [super initWithFrame:frame]) {
        
        // 图片 按钮  文字的初始化
        
        self.bluryView = [bluryView bluryWithbluryImg:bluryImg andFrame:frame andBluryType:blurytype];
        self.isCoverSlide = YES;
        [self addSubview:self.bluryView];
    }
    return self;
}

+ (instancetype)bluryWithbluryImg:(UIImage *)bluryImg andFrame:(CGRect)frame andBluryType:(bluryType)blurytype
{
    return [[self alloc] initWithbluryImg:bluryImg andFrame:frame andBluryType:blurytype];
}

#pragma mark - 控件设置
/**
 *  设置主文本内容
 */
- (void)setMainLabelTitle:(NSString *)title andIsNeedZhe:(BOOL)isneed
{
    if (!self.mainLabel)
    {
        self.mainLabel = [[UILabel alloc] init];
        [self addSubview:self.mainLabel];
    }
    CGFloat contentH = DisCountNoHeight;
    UIFont *fnt = [UIFont systemFontOfSize:90];
    _mainLabel.font = fnt;
    _mainLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _mainLabel.text = title;
    _mainLabel.backgroundColor = [UIColor clearColor];
    _mainLabel.textColor = [UIColor whiteColor];
    CGRect tmpRect = [self.mainLabel.text boundingRectWithSize:CGSizeMake(1000, contentH) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    // 得到宽度
    CGFloat contentW = tmpRect.size.width;
    _mainLabel.frame = CGRectMake((self.frame.size.width - contentW)/2, (self.frame.size.height - contentH)/2 - 30, contentW,contentH);
    
    // 折
    if (isneed)
    {
            if (!self.discount)
        {
            self.discount = [[UILabel alloc] init];
            [self addSubview:self.discount];
            _discount.textColor = [UIColor whiteColor];
            _discount.text = @"折";
            _discount.backgroundColor = [UIColor clearColor];
            _discount.font = [UIFont boldSystemFontOfSize:17];
            CGRect rcDis = self.mainLabel.frame;
            rcDis.origin.x += rcDis.size.width + DisMargin;
            rcDis.origin.y = rcDis.origin.y + rcDis.size.height - DisSize;
            rcDis.size = CGSizeMake(DisSize, DisSize);
            _discount.frame = rcDis;
        }
    }
    
}

/**
 *  设置副文本的内容
 */
- (void)setMinorLabelTitle:(NSString *)title
{
    if (!self.minorLabel)
    {
        self.minorLabel = [[UILabel alloc] init];
        [self addSubview:self.minorLabel];
    }
    CGFloat contentH = MinorHeight;
    UIFont *fnt = [UIFont systemFontOfSize:13];
    _minorLabel.font = fnt;
    _minorLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _minorLabel.text = title;
    _minorLabel.backgroundColor = [UIColor clearColor];
    _minorLabel.textColor = [UIColor lightTextColor];
    CGRect tmpRect = [_minorLabel.text boundingRectWithSize:CGSizeMake(1000, contentH) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:fnt,NSFontAttributeName, nil] context:nil];
    
    // 得到宽度
    CGFloat contentW = tmpRect.size.width;
    _minorLabel.frame = CGRectMake((self.frame.size.width - contentW)/2, self.mainLabel.frame.origin.y + self.mainLabel.frame.size.height + MinorMargin, contentW,contentH);
}

// 设置按钮
-(void)setBtnWithTitle:(NSString *)title andBgColor:(UIColor *)color
{
    if (!self.btn)
    {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.layer.cornerRadius = 5;
        self.btn.clipsToBounds = YES;
        [self.btn addTarget:self action:@selector(getDisCount:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_btn];
    }
    [self.btn setTitle:title forState:UIControlStateNormal];
    [self.btn setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    // 得到相应的高亮颜色
    [self.btn setBackgroundImage:[UIImage imageWithColor:[self getHighlightedColor:color]] forState:UIControlStateHighlighted];
    
    CGRect rcBtn = self.minorLabel.frame;
    rcBtn.origin.x = BtnMarginW;
    rcBtn.origin.y += rcBtn.size.height + BtnMarginH;
    rcBtn.size.width = self.frame.size.width - BtnMarginW * 2;
    rcBtn.size.height = 40;
    self.btn.frame = rcBtn;
}


/**
 *  根据颜色去除RGB 再处理颜色
 *
 *  @param color 传入的颜色
 *
 *  @return <#return value description#>
 */
- (UIColor *)getHighlightedColor:(UIColor *)color
{
    CGFloat r,g,b;
    UIColor *highlightColor = color; // 防止最后返回空
    if ([color getRed:&r green:&g blue:&b alpha:NULL])
    {
        highlightColor = [UIColor colorWithRed:r/2 green:g/2 blue:b/2 alpha:1.0];
    }
    return highlightColor;
}

#pragma mark - btnClick
// 点击按钮事件
- (void)getDisCount:(id)sender
{
    [_btn setTitle:@"去买单" forState:UIControlStateNormal];
}

#pragma mark UISCrollViewDelegate
/**
 *  滑动tableView 修改headerView的frame
 */
- (void)layoutHeaderViewForScrollViewOffset:(CGPoint)offset
{
    // tabelView的headerView是个scrollView，所以tableView的拖动会带动scrollView的变化
    // 往下拖的时候， 上方的scrollView变高，y变负
    CGRect frame = self.bluryView.frame; // 获取当前的frame
    
    if (offset.y > 0) // 往上拖
    {
        // 是否有上拖减速 被盖住的效果
        if (self.isCoverSlide)
            frame.origin.y = MAX(offset.y *kParallaxDeltaFactor, 0); // 如果上移10，y还是10，那仍然在屏幕顶部，不会减少
        else
            frame.origin.y = 0;
       
        self.bluryView.frame = frame;
//        self.bluryView.alpha =   1 / kDefaultHeaderFrame.size.height * offset.y * 2;
        self.clipsToBounds = YES;
    }
    else // 往下拖
    {
        CGFloat delta = 0.0f;
        CGRect rect = kDefaultHeaderFrame; // 原始的大小 375 300
        delta = fabs(MIN(0.0f, offset.y)); // y<=0 取y的绝对值
        rect.origin.y -= delta;
        rect.size.height += delta;
        self.bluryView.frame = rect;
        self.clipsToBounds = NO;
//        self.headerTitleLabel.alpha = 1 - (delta) * 1 / kMaxTitleAlphaOffset; // 下拖100 label就透明
    }
}

@end
