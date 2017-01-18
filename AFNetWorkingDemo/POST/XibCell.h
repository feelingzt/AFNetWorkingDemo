//
//  XibCell.h
//  AFNetWorkingDemo
//
//  Created by 沈家林 on 15/12/28.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JsonPostModel.h"

@interface XibCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)fileDate:(JsonPostModel *)model;

@end
