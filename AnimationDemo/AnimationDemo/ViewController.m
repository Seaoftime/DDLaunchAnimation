//
//  ViewController.m
//  AnimationDemo
//
//  Created by Natsume on 2017/8/9.
//  Copyright © 2017年 RuiZhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    
    [self setDaDaLbAttributedStr];
    
    
    [self addLayerAnimation];
    
    
}





- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self animationDDLb];
    [self animationDDLogo];

}


//label 动画 使用 UIView 动画
- (void)animationDDLb {
    
    [UIView animateWithDuration:0.5f animations:^{
        //放大并模糊
        self.dadaLb.alpha = 0.5f;
        self.dadaLb.layer.transform = CATransform3DMakeScale(1.2f, 1.2f, 1.f);
        
        
    } completion:^(BOOL finished) {
        //恢复并清晰
        [UIView animateWithDuration:0.5f animations:^{
            //
            self.dadaLb.alpha = 1.f;
            self.dadaLb.layer.transform = CATransform3DMakeScale(1.f, 1.f, 1.f);
            
        }];
        
    }];
    
}



//logo 动画 使用 CABasicAniamtion 对象
- (void)animationDDLogo {
    
    CATransform3D transfrom3d = CATransform3DIdentity;
    transfrom3d.m34 = - 1 / 100.f;//设置视点在 z 轴正方向 z = 100
    
    CATransform3D startTransform = CATransform3DTranslate(transfrom3d, 0, 0, - 60);//动画开始时在 z 轴负方向 60
    
    CATransform3D finishTransform = CATransform3DRotate(startTransform, M_PI_2, 0, 1, 0);//动画结束时 绕 y 轴逆时针旋转 90 度
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"transform"];//通过 CABasicAnimation 修改 transform 属性
    //向后移动的同时绕 y 轴逆时针旋转 90 度
    animation1.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation1.toValue = [NSValue valueWithCATransform3D:finishTransform];
    
    
    //**虽然只有1个动画 但用 group 以后好扩展
    CAAnimationGroup *aniamtiongroup = [CAAnimationGroup animation];
    aniamtiongroup.animations = [NSArray arrayWithObjects:animation1, nil];
    aniamtiongroup.duration = 0.5f;
    aniamtiongroup.delegate = self;//回调 动画结束时 调用 animationDidStop
    aniamtiongroup.removedOnCompletion = NO;//动画结束时停止 不回复原样
    
    
    
    [self.logoImgV.layer addAnimation:aniamtiongroup forKey:@"DDAnimatin"];
        
}




// delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {

    if (flag) {
        //
        if (anim == [self.logoImgV.layer animationForKey:@"DDAnimatin"]) {
            //
            CATransform3D transfrom3d = CATransform3DIdentity;
            transfrom3d.m34 = - 1 / 100.f;//设置视点在 z 轴正方向 z = 100
            
            CATransform3D startTransform = CATransform3DTranslate(transfrom3d, 0, 0, - 60);//动画开始时在 z 轴负方向 60
            
            CATransform3D secondTransform = CATransform3DRotate(startTransform, - M_PI_2, 0, 1, 0);//动画结束时 绕 y 轴顺时针旋转 90 度
            
            CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];//通过 CABasicAnimation 修改 transform 属性
            //向前移动的同时绕 y 轴逆时针旋转 90 度
            animation2.fromValue = [NSValue valueWithCATransform3D:secondTransform];
            animation2.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            animation2.duration = 0.5f;
            
            

            
            [self.logoImgV.layer addAnimation:animation2 forKey:@"secondAnimation"];
            
        }
    }


}








- (void)addLayerAnimation {
    
    self.dadaLb.alpha = 0.f;
    self.dadaLb.layer.transform = CATransform3DMakeScale(0.5f, 0.5f, 1.f);
    
}




- (void)setDaDaLbAttributedStr {

    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:@"达达\n可靠配送，在你身边"];
    
    //字体大小
    [attrString addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:30.0f]
                       range:NSMakeRange(0, 2)];
    //字体颜色
    [attrString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blueColor]
                       range:NSMakeRange(0, 2)];
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = 15.f;
    
    [attrString addAttribute:NSParagraphStyleAttributeName
                       value:paragraphStyle
                       range:NSMakeRange(0, attrString.length)];
    
    //对齐方式
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    
    self.dadaLb.attributedText = attrString;
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
