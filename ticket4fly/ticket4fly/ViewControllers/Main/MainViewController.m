//
//  MainViewController.m
//  ticket4fly
//
//  Created by Igor on 11/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    // Add View
    [self addView];
    // Add Label
    [self addLabel];
    // Add Button
    [self addButton];
    // Add TextField
    [self addTextField];
    // Add TextView
    [self addTextView];
    // Add SegmentedControl
    [self addSegmentedControl];
    // Add Slider
    [self addSlider];
    // Add ActivityIndicatorView
    [self addActivityIndicatorView];
    // Add ProgressView
    [self addProgressView];
    // Add ImageView
    [self addImageView];
}

// View
- (void)addView {
    CGRect redViewFrame = CGRectMake(50, 120, 300, 10);
    UIView *redView = [[UIView alloc] initWithFrame: redViewFrame];
    redView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview: redView];
}

// Label
- (void)addLabel {
    CGRect labelFrame = CGRectMake(50.0, 150, 180, 30);
    UILabel *label = [[UILabel alloc] initWithFrame: labelFrame];
    label.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightBold];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = @"Какой-то лейбл...";
    [self.view addSubview: label];
}

//Button
- (void)addButton {
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, 200, 200.0, 50.0);
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"Меняем цвет фона View." forState:UIControlStateNormal];
    button.backgroundColor = [UIColor greenColor];
    button.tintColor = [UIColor blackColor];
    button.frame = frame;
    [button addTarget:self action:@selector(changeColorButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)changeColorButtonDidTap:(UIButton *)sender
{
    if ([self.view.backgroundColor isEqual: [UIColor lightGrayColor]]) {
        self.view.backgroundColor = [UIColor darkGrayColor];
    } else {
        self.view.backgroundColor = [UIColor lightGrayColor];
    }
}

//TextField
- (void)addTextField {
    CGRect frame = CGRectMake(50, 260, [UIScreen mainScreen].bounds.size.width - 100.0, 50.0);
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Введите текст сюда!";
    textField.font = [UIFont systemFontOfSize:20.0 weight:UIFontWeightLight];
    [self.view addSubview: textField];
}

//TextView
- (void)addTextView {
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, 320, 200.0, 60.0);
    UITextView *textView = [[UITextView alloc] initWithFrame: frame];
    textView.backgroundColor = [UIColor blackColor];
    textView.textColor = [UIColor orangeColor];
    textView.text = @"Урок 1. Создание приложений и основных UI компонентов без применения Interface Builder";
    [self.view addSubview:textView];
}

//SegmentedControl
- (void)addSegmentedControl {
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 - 100.0, 400, 200.0, 20.0);
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Left", @"Right"]];
    segmentedControl.frame = frame;
    segmentedControl.tintColor = [UIColor purpleColor];
    segmentedControl.selectedSegmentIndex = 0;
    [self.view addSubview:segmentedControl];
}

//Slider
- (void)addSlider {
    CGRect frame = CGRectMake(60, [UIScreen mainScreen].bounds.size.height/2 + 25, [UIScreen mainScreen].bounds.size.width - 120, 50);
    UISlider *slider = [[UISlider alloc] init];
    slider.frame = frame;
    slider.tintColor = [UIColor orangeColor];
    slider.value = 0.7;
    slider.thumbTintColor = [UIColor redColor];
    [self.view addSubview:slider];
}

//ActivityIndicatorView
- (void)addActivityIndicatorView {
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.color = [UIColor redColor];
    activityIndicatorView.frame = CGRectMake(5, [UIScreen mainScreen].bounds.size.height/2 + 25, 50, 50);
    activityIndicatorView.hidesWhenStopped = YES;
    [activityIndicatorView startAnimating];
    [self.view addSubview:activityIndicatorView];
}

//ProgressView
- (void)addProgressView {
    CGRect frame = CGRectMake(25, [UIScreen mainScreen].bounds.size.height/2 + 85, [UIScreen mainScreen].bounds.size.width - 50, 50);
    UIProgressView *progressView = [[UIProgressView alloc] initWithProgressViewStyle: UIProgressViewStyleDefault];
    progressView.progressTintColor = [UIColor blackColor];
    progressView.frame = frame;
    progressView.progress = 0.11;
    [self.view addSubview:progressView];
}

//ImageView
- (void)addImageView {
    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2 -100, [UIScreen mainScreen].bounds.size.height/2 + 140, 200.0, 200.0);
    UIImageView *imageView = [[UIImageView alloc] initWithFrame: frame];
    imageView.image = [UIImage imageNamed:@"logo-objectiveC"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:imageView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
