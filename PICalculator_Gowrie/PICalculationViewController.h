//
//  ViewController.h
//  PICalculator_Gowrie
//
//  Created by Gowrie Sammandhamoorthy on 9/21/15.
//  Copyright (c) 2015 Gowrie Sammandhamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PICalculationViewController : UIViewController

- (IBAction)startAcion:(UIButton *)sender;
- (IBAction)pauseAction:(UIButton *)sender;
- (IBAction)stopAction:(UIButton *)sender;
-(void) pi_digits;

@property (weak, nonatomic) IBOutlet UILabel *elapsedTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UILabel *piValueLabel;
@property (weak, nonatomic) IBOutlet UITextView *piValueTextView;

@end

