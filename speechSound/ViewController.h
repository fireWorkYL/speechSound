//
//  ViewController.h
//  speechSound
//
//  Created by 楚简约 on 2017/8/2.
//  Copyright © 2017年 mlgentleman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


// 开始
@property (weak, nonatomic) IBOutlet UIButton *btn1;
// 暂停/继续
@property (weak, nonatomic) IBOutlet UIButton *btn2;
// 结束
@property (weak, nonatomic) IBOutlet UIButton *btn3;


@property (weak, nonatomic) IBOutlet UILabel *speakLabel;



@end

