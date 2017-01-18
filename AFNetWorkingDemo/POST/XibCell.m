//
//  XibCell.m
//  AFNetWorkingDemo
//
//  Created by 沈家林 on 15/12/28.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import "XibCell.h"
#import "UIImageView+WebCache.h"

@implementation XibCell

-(void)fileDate:(JsonPostModel *)model{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.picUrl]];
    _nameLabel.text=model.itemName;
    _desLabel.text=model.subscibe;
    _timeLabel.text=model.time;
}

//当控件从xib/storyboard中创建完毕时，就会调用这个方法
//当控件从xib/storyboard中创建完毕后的初始化操作，应该在这个方法中执行
- (void)awakeFromNib {
    _headImageView.layer.cornerRadius=5;
    _headImageView.layer.masksToBounds=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
