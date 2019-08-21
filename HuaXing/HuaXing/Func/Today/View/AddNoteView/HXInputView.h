//
//  HXInputView.h
//  HuaXing
//
//  Created by hnbwyh on 2019/8/21.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^InputViewUpdateHeightBlock)(CGFloat h);
typedef void(^InputViewDidEndEditBlock)(NSString *rlt);
@interface HXInputView : UIView

+ (CGFloat)minHeight;

@property (nonatomic,copy) NSString *placeHolder;

// 高度更新回调
@property (nonatomic,copy) InputViewUpdateHeightBlock updateHeightBlock;

// 编辑结束回调
@property (nonatomic,copy) InputViewDidEndEditBlock   endEditBlock;

// 字体样式
@property (nonatomic,strong) UIFont                   *textFont;

// 内容填充
@property (nonatomic,copy)  NSString                  *bindedContent;

// 结束编辑态
- (void)resignFirstResponder;


@end

NS_ASSUME_NONNULL_END
