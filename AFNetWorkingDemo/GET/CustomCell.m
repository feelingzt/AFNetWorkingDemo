//
//  CustomCell.m
//  AFNetWorkingDemo
//
//  Created by uen on 16/12/1.
//  Copyright © 2016年 UEN. All rights reserved.
//

#import "CustomCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "Header.h"

@implementation CustomCell
{
    UIImageView *_headImageView;
    UILabel *_nameLabel;
    UILabel *_desLabel;
    UILabel *_timeLabel;
}

//指定的初始化程序。如果cell可以重用，你必须通过一个重用标识符。你应该使用相同的标识符让所有的cell以相同的形式重用
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configCell];
    }
    return self;
}

-(void)fileData:(JsonGetModel *)model{
    NSURL *url=[NSURL URLWithString:model.iconUrl];
    
    /*
     1、SDWebImage
     提供一个UIImageView的类别以支持加载来自网络的远程图片。
     具有缓存管理、异步下载、同一个URL下载次数控制和优化等特征.
     2、SDWebImage主要用到了"UIImageView+WebCache.h"在要使用它的类中加入#import "UIImageView+WebCache.h",就可以调用sd_setImageWithURL:(NSURL *) placeholderImage:(UIImage *)该方法从异步下载到缓存管理，一切都会为你处理。
     */
    
    //让_headImageView 异步加载url中的图片,加载完成后赋值给_headImageView.image
    [_headImageView sd_setImageWithURL:url];
    
    //下面这种方法会阻塞主线程(会给用户一种卡的感觉)，不能使用
    //NSData *data=[NSData dataWithContentsOfURL:url];
    //_headImageView.image=[UIImage imageWithData:data];
    
    _nameLabel.text=model.name;
    _desLabel.text=model.description1;
    _timeLabel.text=model.updateDate;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)configCell
{
    //    _headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10*KRate, 10, 80, 80)];
    //    _headImageView.layer.cornerRadius=5;
    //    _headImageView.layer.masksToBounds=YES;
    //    _headImageView.contentMode=UIViewContentModeScaleAspectFill;
    //    //一般自定义cell,往cell上加控件是用content view,不是view.
    //    //把子视图加在contentView上，进入/退出编辑模式时候，子视图位置可以自动适应（子视图不会在UITableViewCell边界外）
    //    [self.contentView addSubview:_headImageView];
    //
    //    _nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(100*KRate,10,(320-100-10)*KRate, 20)];
    //    _nameLabel.textColor=[UIColor blueColor];
    //    _nameLabel.font=[UIFont systemFontOfSize:15];
    //    [self.contentView addSubview:_nameLabel];
    //
    //    _desLabel=[[UILabel alloc]initWithFrame:CGRectMake(100*KRate, 10+20+5, (320-100-10)*KRate, 20)];
    //    _desLabel.textColor=[UIColor redColor];
    //    _desLabel.font=[UIFont systemFontOfSize:15];
    //    [self.contentView addSubview:_desLabel];
    //
    //    _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(100*KRate, 35+20+5, (320-100-10)*KRate, 20)];
    //    _timeLabel.textColor=[UIColor yellowColor];
    //    _timeLabel.font=[UIFont systemFontOfSize:15.0];
    //    _timeLabel.textAlignment=NSTextAlignmentRight;
    //    [self.contentView addSubview:_timeLabel];
    
    kWS(ws);
    _headImageView = [UIImageView new];
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws.contentView).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    _nameLabel = [UILabel new];
    _nameLabel.textColor = [UIColor blueColor];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(ws.contentView).offset(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.mas_equalTo(@20);
        //make.size.mas_equalTo(CGSizeMake(210, 20));
    }];
    
    
    _desLabel = [UILabel new];
    _desLabel.textColor = [UIColor blackColor];
    _desLabel.font = [UIFont systemFontOfSize:15];
    //写几就几行  0:自动换行//设置自动换行也要设置lineBreakMode是NSLineBreakByCharWrapping(解释：Wrap at character boundaries)
    //label.numberOfLines = 1;
    //sizeToFit:自适应label高度
    //    [label sizeToFit];
    //省略号的位置：lineBreakMode
    /*
     1、NSLineBreakByTruncatingHead   前面省略
     2、NSLineBreakByTruncatingMiddle 中间省略
     3、NSLineBreakByTruncatingTail   后面省略
     */
    // label.lineBreakMode = NSLineBreakByTruncatingTail;
    _desLabel.numberOfLines = 1;
    //_desLabel.lineBreakMode = NSLineBreakByCharWrapping;
    _desLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self.contentView addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_nameLabel.mas_bottom).offset(10);
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.mas_equalTo(@20);
        //make.size.mas_equalTo(CGSizeMake(210, 20));
    }];
    
    _timeLabel = [UILabel new];
    _timeLabel.textColor = [UIColor blackColor];
    _timeLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headImageView.mas_right).offset(10);
        make.top.equalTo(_desLabel.mas_bottom).offset(10);
        
        make.right.equalTo(ws.contentView).offset(-10);
        make.height.mas_equalTo(@20);
        //make.size.mas_equalTo(CGSizeMake(210, 20));
    }];
    
    
}

@end


/*
 instancetype和id
 1、相同点：作为方法的返回类型
 2、不同点：
 instancetype可以返回和方法所在类相同类型的对象，id只能返回未知类型的对象。
 instancetype只能作为返回值，id可以作为参数
 */


/*
 //当控件通过代码创建时，就会调用这个方法
 //当控件通过代码创建时，控件想做一些初始化操作，应该在这个方法中执行
 - (instancetype)initWithFrame:(CGRect)frame
 {
 self = [super initWithFrame:frame];
 if (self) {
 
 }
 return self;
 }
 
 //当控件从xib/storyboard中创建完毕时，就会调用这个方法来初始化控件
 - (id)initWithCoder:(NSCoder *)aDecoder
 {
 self = [super initWithCoder:aDecoder];
 if (self) {
 
 }
 return self;
 }
 //当控件从xib/storyboard中创建完毕时，就会调用这个方法
 //当控件从xib/storyboard中创建完毕后的初始化操作，应该在这个方法中执行
 //这个方法比上面的方法相比好一些
 //继承UITableViewCell创建类，这个方法是xcode自动提供的方法
 - (void)awakeFromNib
 {
 // Initialization code
 }
 */

