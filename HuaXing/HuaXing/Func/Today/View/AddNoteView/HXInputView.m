//
//  HXInputView.m
//  HuaXing
//
//  Created by hnbwyh on 2019/8/21.
//  Copyright © 2019 HuaXing. All rights reserved.
//

#import "HXInputView.h"

@interface HXInputView () <UITextFieldDelegate,UITextViewDelegate>

@property (nonatomic,strong) UITextView *txtView;

@property (nonatomic,strong) UITextField *placeHolderField;

@end

@implementation HXInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    [self addSubview:self.txtView];
    [self.txtView addSubview:self.placeHolderField];
    CGRect rect = self.bounds;
    rect.size.height = [[self class] minHeight];
    [self.txtView setFrame:rect];
    [self.placeHolderField setFrame:rect];
    
//    self.backgroundColor = [UIColor blueColor];
//    self.txtView.backgroundColor = [UIColor greenColor];
//    self.placeHolderField.backgroundColor = [UIColor redColor];
}

- (void)showField {
    self.txtView.text = @"";
    [self.placeHolderField becomeFirstResponder];
    self.placeHolderField.hidden = FALSE;
}

- (void)hiddenField {
    self.txtView.text = self.placeHolderField.text;
    self.placeHolderField.text = @"";
    [self.txtView becomeFirstResponder];
    self.placeHolderField.hidden = TRUE;
}

- (void)updateTextViewFrame {
    [self.txtView sizeToFit];
    CGRect curRct = self.txtView.bounds;
    CGFloat h = curRct.size.height;
    CGRect rect = self.placeHolderField.bounds;
    CGFloat tmp = rect.size.height;
    rect.size.height = MAX(tmp, h);
    [self.txtView setFrame:rect];
    if (self.updateHeightBlock) {
        self.updateHeightBlock(CGRectGetHeight(rect));
    }
}

+ (CGFloat)minHeight {
    return 26.f;
}

#pragma mark --- tagrget

- (void)eventValueChangedForTextField:(UITextField *)textField {
    NSString *cnt = textField.text;
    if (cnt && cnt.length > 0) {
        [self hiddenField];
    }
}

#pragma mark --- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    NSString *cnt = textView.text;
    if (cnt == nil || cnt.length <= 0) {
        [self showField];
    }
    [self updateTextViewFrame];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    NSString *cnt = textView.text;
    if (self.endEditBlock) {
        self.endEditBlock(cnt);
    }
}

#pragma mark --- setter

-(void)setPlaceHolder:(NSString *)placeHolder {
    if (placeHolder) {
        _placeHolder = placeHolder;
        self.placeHolderField.placeholder = placeHolder;
    }
}

-(void)setTextFont:(UIFont *)textFont {
    if (textFont) {
        _textFont = textFont;
        self.placeHolderField.font = textFont;
        self.txtView.font = textFont;
    }
}

-(void)setBindedContent:(NSString *)bindedContent {
    if (bindedContent) {
        _bindedContent = bindedContent;
        [self hiddenField];
        self.txtView.text = bindedContent;
        [self updateTextViewFrame];
    }
}

#pragma mark --- outer 

-(void)resignFirstResponder {
    [self.placeHolderField resignFirstResponder];
    [self.txtView resignFirstResponder];
}

#pragma mark --- lazy load

-(UITextView *)txtView {
    if (!_txtView) {
        _txtView = [[UITextView alloc] init];
        _txtView.bounces = FALSE;
        _txtView.delegate = (id)self;
    }
    return _txtView;
}

-(UITextField *)placeHolderField {
    if (!_placeHolderField) {
        _placeHolderField = [[UITextField alloc] init];
        _placeHolderField.delegate = (id)self;
        [_placeHolderField addTarget:self action:@selector(eventValueChangedForTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _placeHolderField;
}

@end
