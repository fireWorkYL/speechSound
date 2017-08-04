//
//  ViewController.m
//  speechSound
//
//  Created by 楚简约 on 2017/8/2.
//  Copyright © 2017年 mlgentleman. All rights reserved.
//

#import "ViewController.h"
#import<AVFoundation/AVFoundation.h>


@interface ViewController ()<AVSpeechSynthesizerDelegate>
// 合成器 控制播放，暂停
@property(nonatomic,strong) AVSpeechSynthesizer * synthesizerAV;
// 实例化发声的对象，及朗读的内容，可以控制说话的语速 等
@property(nonatomic,strong) AVSpeechUtterance *utterance;


//用于设置 暂停/继续按钮
@property(nonatomic,assign) BOOL isSpeak;
//避免重复加入队列,造成崩溃
@property(nonatomic,assign) BOOL isAction;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //模拟服务器返回数据
    NSString *content = @"<p>　　日前，湖北邮政公司党组对全省邮政企业30个红旗支局党支部开展了示范引领“回头看”检查，检查指标涉及党员“三亮”载体覆盖率、业务收入增幅等10项党建工作及经营管理指标。检查结果显示，全省邮政企业30个红旗党支部示范引领作用十分明显，主要表现为三个方面：一是党建工作真正落地。全省邮政企业30个红旗支局党支部扎实开展了“三亮三比三创”活动，充分发挥了党员的先锋模范作用，党员劳动竞赛完成率均在100%以上，党员“三亮”载体覆盖率均为100%。同时，各支部明确了特色支部的建设方向，加强了党员队伍建设。二是业务收入快速增长。全省邮政企业30个红旗支局党支部所在支局共实现业务收入2。15亿元，净增业务收入2660万元，平均增幅16。5%，其中武汉市江夏区城关支局党支部所在支局业务收入增幅达46%、荆门市沙洋县沈集支局党支部所在支局业务收入增幅达37。95%、孝感市肖港支局党支部所在支局业务收入增幅达30。2%，收入增长势头喜人；人均劳动生产率达到37。26万元，其中孝感市三汊支局党支部、胡金店支局党支部、肖港支局党支部所在支局劳动生产率分别达到59万元、58。4万元、57。5万元，业绩表现突出。三是储蓄余额规模快速扩张。全省邮政企业30个红旗支局党支部所在支局累计储蓄余额规模达到198。49亿元，1-7月份新增储蓄余额过亿的有11个支局，其中武汉市韩家墩支局党支部、钟家村支局党支部以及青山区钢花支局党支部所在支局新增储蓄余额分别达到4。89亿元、2。51亿元和2。12亿元，储蓄余额增长势头强劲。<br></p>";
    //去除HTML标签处理
    NSString *contentStr = [self filterHTML:content];
    //将Unicode转变为字符串时"."->"。",需要替换字符
    NSString *contentString = [contentStr stringByReplacingOccurrencesOfString:@"。" withString:@"."];
    
    self.speakLabel.text = contentStr;
    
    //语音播报 (研究)
    _synthesizerAV = [[AVSpeechSynthesizer alloc] init];
    _utterance = [AVSpeechUtterance speechUtteranceWithString:contentString];
    // 语速 0.0f～1.0f   AVSpeechUtteranceMaximumSpeechRate / 4.0f;
    _utterance.rate = 0.5f;
    // 声音的音调 0.5f～2.0f
    _utterance.pitchMultiplier = 0.8f;
    //设置合成语音的语言 defaults to your system language
    _utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    //设置朗读的音量 [0-1] Default = 1
    _utterance.volume = 0.8;
    
    
    _isSpeak = NO;
    _isAction = NO;
    
    
    //不离屏渲染,UILabel特有高效裁剪圆角方式,可以用在TableViewCell做角标,对TableView进行优化
    UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, 18, 18)];
    tagLabel.text = @"减";
    tagLabel.textAlignment = NSTextAlignmentCenter;
    tagLabel.textColor = [UIColor whiteColor];
    tagLabel.font = [UIFont systemFontOfSize:13];
    tagLabel.layer.backgroundColor = [UIColor redColor].CGColor;
    tagLabel.layer.cornerRadius = 5;
    
    [self.view addSubview:tagLabel];
}



//开始
- (IBAction)clickActionBtn:(id)sender {
    
    if (!_isAction) {
        NSLog(@"开始");
        _isAction = YES;
        [_synthesizerAV speakUtterance:_utterance];
    }
}

//暂停/继续
- (IBAction)clickSuspendBtn:(id)sender {
    
    if (!_isSpeak) {
        NSLog(@"暂停");
        _isSpeak = YES;
        [_btn2 setTitle:@"继续" forState:UIControlStateNormal];
        [_synthesizerAV pauseSpeakingAtBoundary:AVSpeechBoundaryWord];//暂停
    }else {
        NSLog(@"继续");
        _isSpeak = NO;
         [_btn2 setTitle:@"暂停" forState:UIControlStateNormal];
        [_synthesizerAV continueSpeaking];
    }
}

//结束
- (IBAction)clickEndBtn:(id)sender {
    NSLog(@"结束");
    _isAction = NO;
    _isSpeak = NO;
    [_btn2 setTitle:@"暂停" forState:UIControlStateNormal];
    [_synthesizerAV stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
}





//处理HTML标签
-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
