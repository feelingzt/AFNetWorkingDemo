//
//  JsonPostViewController.m
//  AFNetWorkingDemo
//
//  Created by 沈家林 on 15/12/28.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import "JsonPostViewController.h"
#import "XibCell.h"
#import "AFNetworking.h"
#import "JsonPostModel.h"
#import "Header.h"

@interface JsonPostViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
}
@end

@implementation JsonPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArray=[NSMutableArray new];
    [self configUI];
    [self loadData];
}

#pragma mark -- Data相关
-(void)loadData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/text",nil];
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setObject:@"getRemmendJournalByUserDeviceID" forKey:@"m"];
    [dic setObject:@"10" forKey:@"pageSize"];
    [dic setObject:@"0" forKey:@"pageIndex"];
    [dic setObject:@"7B63373363386530373034366164393262633633373039326138356238366366307D2C7B336464363563386338626263653130663531623832616632343963363832323065363964656161627D2C7B66616C73657D2C7B307D2C7B307D2C7B66373539333863642D326162352D346232342D616336622D3132386538626434663366397D2C7B37363033396665333533326461623034656561353162363734643131636532617D2C7B323031352D30332D30372031313A31383A33337D2C7B312E382E367D2C7B696F736C6974657261747572657D2C7B494F536C6974657261747572655F312E382E365F696F73382E312E335F6950686F6E65352D327D" forKey:@"sessionKey"];
    [dic setObject:@"2" forKey:@"rtype"];
    /*
     第一个参数：请求的网址
     第二个参数：要传给服务端的数据
     第三个参数：成功调用的block
     第四个参数：失败调用的block
     */
    [manager POST:JsonPost parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        NSArray *array=[responseObject objectForKey:@"obj"];
        for (NSDictionary *dic in array) {
            JsonPostModel *model=[[JsonPostModel alloc]init];
            model.picUrl=dic[@"picUrl"];
            model.itemName=dic[@"itemName"];
            model.subscibe=[NSString stringWithFormat:@"%@",dic[@"subscibe"]];
            NSDictionary *createDate=dic[@"createDate"];
            model.time=[NSString stringWithFormat:@"%@年%@月%@日",createDate[@"year"],createDate[@"month"],createDate[@"day"]];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
#pragma mark -- UI相关

-(void)configUI{
    self.automaticallyAdjustsScrollViewInsets=NO;
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [_tableView registerNib:[UINib nibWithNibName:@"XibCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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
    XibCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    [cell fileDate:_dataArray[indexPath.row]];
    return cell;
}

@end
