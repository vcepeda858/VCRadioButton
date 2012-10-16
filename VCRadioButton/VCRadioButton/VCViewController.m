//
//  VCViewController.m
//  VCRadioButton
//
//  Created by Vincent Cepeda.
//

#import "VCViewController.h"
#import "VCRadioButton.h"

#define kGroup1Name @"group1"
#define kGroup2Name @"group2"

@interface VCViewController ()
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton1;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton2;
@property (weak, nonatomic) IBOutlet VCRadioButton *group1RadioButton3;
@property (weak, nonatomic) IBOutlet VCRadioButton *noGroupRadioButton1;
@property (weak, nonatomic) IBOutlet VCRadioButton *noGroupRadioButton2;
@property (weak, nonatomic) IBOutlet VCRadioButton *noGroupRadioButton3;
@property (weak, nonatomic) IBOutlet VCRadioButton *group2RadioButton1;
@property (weak, nonatomic) IBOutlet VCRadioButton *group2RadioButton2;
@property (weak, nonatomic) IBOutlet VCRadioButton *group2RadioButton3;
@end

@implementation VCViewController

#pragma mark - view life cycle
- (void)viewDidLoad{
    // block of code to execute on selection and deselection
    RadioButtonControlSelectionBlock selectionBlock = ^(VCRadioButton *radioButton){
        if (radioButton.groupName)
            NSLog(@"RadioButton from group:%@ was:%@ and has a value of:%@",
                  radioButton.groupName,
                  (radioButton.selected)? @"selected" : @"deselected",
                  radioButton.selectedValue);
        else
            NSLog(@"RadioButton with value of:%@ was:%@",
                  radioButton.selectedValue,
                  (radioButton.selected)? @"selected" : @"deselected");
    };
    
    // assign the selection block to each radio button
    self.group1RadioButton1.selectionBlock = selectionBlock;
    self.group1RadioButton2.selectionBlock = selectionBlock;
    self.group1RadioButton3.selectionBlock = selectionBlock;
    self.noGroupRadioButton1.selectionBlock = selectionBlock;
    self.noGroupRadioButton2.selectionBlock = selectionBlock;
    self.noGroupRadioButton3.selectionBlock = selectionBlock;
    self.group2RadioButton1.selectionBlock = selectionBlock;
    self.group2RadioButton2.selectionBlock = selectionBlock;
    self.group2RadioButton3.selectionBlock = selectionBlock;
    
    // this code below is used to tell a set of radio buttons they are in the same group
    // group names
    self.group1RadioButton1.groupName = kGroup1Name;
    self.group1RadioButton2.groupName = kGroup1Name;
    self.group1RadioButton3.groupName = kGroup1Name;
    self.group2RadioButton1.groupName = kGroup2Name;
    self.group2RadioButton2.groupName = kGroup2Name;
    self.group2RadioButton3.groupName = kGroup2Name;
    
    // this code below gives each radio button a selection value
    self.group1RadioButton1.selectedValue = @"1";
    self.group1RadioButton2.selectedValue = @"2";
    self.group1RadioButton3.selectedValue = @"3";
    self.noGroupRadioButton1.selectedValue = @"4";
    self.noGroupRadioButton2.selectedValue = @"5";
    self.noGroupRadioButton3.selectedValue = @"6";
    self.group2RadioButton1.selectedValue = @"7";
    self.group2RadioButton2.selectedValue = @"8";
    self.group2RadioButton3.selectedValue = @"9";
    
    // this code below is only if you choose to change the colors of the radio buttons
    // group 2 will use various colors
    self.group2RadioButton1.controlColor = [UIColor redColor];
    self.group2RadioButton2.controlColor = [UIColor colorWithRed:0.929 green:0.929 blue:0.929 alpha:1]; /*#ededed*/
    self.group2RadioButton3.controlColor = [UIColor blueColor];
    self.group2RadioButton1.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.group2RadioButton2.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
    self.group2RadioButton3.selectedColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1];
}
@end
