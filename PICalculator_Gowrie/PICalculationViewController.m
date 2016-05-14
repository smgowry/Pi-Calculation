//
//  ViewController.m
//  PICalculator_Gowrie
//
//  Created by Gowrie Sammandhamoorthy on 9/21/15.
//  Copyright (c) 2015 Gowrie Sammandhamoorthy. All rights reserved.
//    By ramesh

#import "PICalculationViewController.h"

@interface PICalculationViewController ()
@property (atomic, assign) BOOL cancel;
@end

@implementation PICalculationViewController

double pi;
@synthesize pauseButton;
@synthesize piValueLabel;
@synthesize elapsedTimeLabel;
@synthesize piValueTextView;
 NSDate* startTime;
 NSDate* endTime;
 NSTimeInterval elapsedTime;
 NSTimeInterval executionTime;
 NSTimer *timer;
 NSString* firstString;
 NSMutableString* secondString;
int i;

double result;
- (void)viewDidLoad {
 [super viewDidLoad];
    firstString = [[NSString alloc]init];
    secondString = [[NSMutableString alloc]init];
   }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pi_digits {
    startTime = [NSDate date] ;
    pi =0.0;
    double a[10] = {0};
    double b[10] = {0};
    double t[10] = {0};
    double p[10] = {0};
    i=0;
    a[0] =1.0;
    b[0]= 1.0/sqrt(2.0);
    t[0]=1.0/4.0;
    p[0]=1.0;
    for(i=0; i<10; i++) {
        a[i+1]= (a[i]+b[i])/2;
        b[i+1]= sqrt((a[i]*b[i]));
        t[i+1]= t[i]-(p[i]*pow(a[i]-a[i+1],2));
        p[i+1]= 2*p[i];
        pi = (pow(a[i]+b[i],2))/(4*t[i]);
        endTime = [NSDate date] ;
        elapsedTime = [endTime timeIntervalSinceDate:startTime];
        executionTime+=elapsedTime;
        NSLog(@"Elapsed Time is: %f",elapsedTime);
        firstString = [NSString stringWithFormat:@"Iteration:%i\nValue:%.52f\n",i,pi];
        NSLog(@"first String %@ ",firstString);
        [secondString appendString:firstString];
    // NSLog(@"second String %@ ",secondString);
    dispatch_async(dispatch_get_main_queue(), ^{
            piValueLabel.text=[NSString stringWithFormat:@"%.10f",pi];
            piValueTextView.text = secondString;
            // NSLog(@"executionTime:%f",elapsedTime);
            elapsedTimeLabel.text = [NSString stringWithFormat:@"%f",executionTime];
 });
    }
    }

- (IBAction)startAcion:(UIButton *)sender {
   [timer invalidate];
     executionTime=0;
  [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    dispatch_queue_t queue = dispatch_queue_create("calculationQueue", nil);
    dispatch_async(queue, ^{
         timer=[NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(pi_digits) userInfo:nil repeats:NO];
      [timer fire];
    });
}

- (IBAction)pauseAction:(UIButton *)sender {
  [timer invalidate];
    if([pauseButton.currentTitle isEqualToString:@"Pause"]){
        [timer invalidate];
      [pauseButton setTitle:@"Resume" forState:UIControlStateNormal];
    }else{
        timer=[NSTimer scheduledTimerWithTimeInterval:1.0/10 target:self selector:@selector(pi_digits) userInfo:nil repeats:YES];
        [timer fire];
     [pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (IBAction)stopAction:(UIButton *)sender{
    self.cancel = YES;
    piValueLabel.text = @"";
    elapsedTimeLabel.text= @"";
    piValueTextView.text = @"";
    executionTime=0;
   [timer invalidate];
}
@end
