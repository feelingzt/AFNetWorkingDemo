//
//  Header.h
//  AFNetWorkingDemo
//
//  Created by uen on 16/12/1.
//  Copyright © 2016年 UEN. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHeight [UIScreen mainScreen].bounds.size.height

#define kWS(ws) __weak typeof(&*self) ws=self

//json数据get请求
#define JsonGet @"http://iappfree.candou.com:8080/free/applications/limited?currency=rmb&page=1"
//json数据post请求
#define JsonPost @"http://services.xingshulin.com/ApricotForestWirelessServiceForLiterature/LiteratureDataServlet"

#endif /* Header_h */
