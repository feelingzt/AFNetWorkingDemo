//
//  JsonGetViewController.m
//  AFNetWorkingDemo
//
//  Created by uen on 16/12/1.
//  Copyright © 2016年 UEN. All rights reserved.
//

#import "JsonGetViewController.h"
#import "CustomCell.h"
#import "JsonGetModel.h"
#import "AFNetworking.h"//大部分的第三方库都有一个同名的.h文件，我们只要导入这个.h文件，就可以使用第三方库
#import "Header.h"


@interface JsonGetViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation JsonGetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=[NSMutableArray new];
    /*
     注意，因为loadData中网络请求用到了_tableView,而_tableView是在configUI中创建的，所以一定要先configUI再loadData。
     
     也可以在loadData中这样写
     dispatch_async(dispatch_get_main_queue(), ^{
     [_tableView reloadData];
     });
     
     */
    [self configUI];
    [self loadData];
    [self judgeNetState];
    
}
#pragma mark 判断网络当前状态
-(void)judgeNetState{
    AFHTTPRequestOperationManager *manager=[[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://baidu.com"]];
    //监测网络状态的方法（当网络当前状态发生变化的时候，调用block）
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusNotReachable     = 0,
         没有连接网络
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         当前网络是无线广域网（3G/4G/GPS/2G）
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         当前网络是wifi
         */
        if (status==AFNetworkReachabilityStatusNotReachable) {
            NSLog(@"---没有链接网络");
        }else if (status==AFNetworkReachabilityStatusReachableViaWWAN) {
            NSLog(@"---3G/4G/GPS等无形广域网");
        }else if(status==AFNetworkReachabilityStatusReachableViaWiFi){
            NSLog(@"---wifi");
        }
    }];
    //开始监测
    [manager.reachabilityManager startMonitoring];
}


#pragma mark 请求数据
-(void)loadData{
    //创建数据请求的对象，不是单例
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    //设置响应数据的类型,如果是json数据，会自动帮你解析
    //注意setWithObjects后面的s不能少
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", nil];
    /*
     第一个参数：请求的地址
     第二个参数：需要传给服务端的参数
     第三个参数：数据请求成功回调的block >>>成功后的数据：responseObject
     第四个参数：数据请求失败回调的block >>>失败后的原因：error
     */
    [manager GET:JsonGet parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=(NSDictionary *)responseObject;
        NSArray *applications=dic[@"applications"];
        
        for (NSDictionary *item in applications) {
            JsonGetModel *model=[[JsonGetModel alloc]init];
            model.iconUrl = item[@"iconUrl"];
            model.name = item[@"name"];
            model.description1 = item[@"description"];
            model.updateDate = item[@"updateDate"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark -- 搭建UI
-(void)configUI
{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId=@"cell";
    CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    
    //CustomCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    //if (!cell) {
    //cell=[[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    //}
    
    [cell fileData:_dataArray[indexPath.row]];
    return cell;
}

@end
