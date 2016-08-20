//
//  FilterViewController.m
//  Troca Legal
//
//  Created by Jota Melo on 20/08/16.
//  Copyright © 2016 Avenue Code Brazil. All rights reserved.
//

#import "FilterViewController.h"


@interface FilterViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *categoryTextField;
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceFromTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceToTextField;

@property (strong, nonatomic) UIPickerView *categoriesPickerView;
@property (strong, nonatomic) UIPickerView *brandPickerView;

@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *brands;

@end

@implementation FilterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupPickerViews];
}

- (void)setupPickerViews
{
    self.categories = @[@{@"id": @"jYnfdomVNH", @"name": @"Bota Imobilizadora"},
                        @{@"id": @"iLBH3Fct6h", @"name": @"Muletas"},
                        @{@"id": @"9EOFbUoaLo", @"name": @"Cadeira de Rodas"}];
    
    self.brands = @[@{@"id": @"HLFlCTj302", @"name": @"Mercur"},
                    @{@"id": @"7tWipvy0Wb", @"name": @"Ortho Pauher"},
                    @{@"id": @"OiRok6vkQs", @"name": @"ReSound"},
                    @{@"id": @"7mOEaSkFHT", @"name": @"Oticon"},
                    @{@"id": @"KI2LCsHZFM", @"name": @"Simens"},
                    @{@"id": @"GZnjb8FMbw", @"name": @"Lemat"},
                    @{@"id": @"8CNWBYQhid", @"name": @"Dilepe"},
                    @{@"id": @"ltkSZafIeN", @"name": @"CDS"},
                    @{@"id": @"u7bU17bVSE", @"name": @"Carone"},
                    @{@"id": @"z1wVrXwagN", @"name": @"Carci"},
                    @{@"id": @"vXuGr9nIr2", @"name": @"Baxmann Jaguaribe"}];
    
    self.categoriesPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(.0f, .0f, self.view.frame.size.width, 216.f)];
    self.categoriesPickerView.delegate = self;
    self.categoriesPickerView.dataSource = self;
    self.categoryTextField.inputView = self.categoriesPickerView;
    
    self.brandPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(.0f, .0f, self.view.frame.size.width, 216.f)];
    self.brandPickerView.delegate = self;
    self.brandPickerView.dataSource = self;
    self.brandTextField.inputView = self.brandPickerView;
}

- (IBAction)go:(id)sender
{
    Filter *filter = [Filter new];
    
    if (self.categoryTextField.text.length > 0) {
        NSUInteger selectedCategoryIndex = [self.categoriesPickerView selectedRowInComponent:0];
        filter.category = self.categories[selectedCategoryIndex - 1][@"id"];
    }
    
    if (self.brandTextField.text.length > 0) {
        NSUInteger selectedBrandIndex = [self.brandPickerView selectedRowInComponent:0];
        filter.brand = self.brands[selectedBrandIndex - 1][@"id"];
    }
    
    if (self.priceFromTextField.text.length > 0 && self.priceToTextField.text.length > 0) {
        filter.priceTo = @([self.priceToTextField.text floatValue]);
        filter.priceFrom = @([self.priceFromTextField.text floatValue]);
    }
    
    if (self.completionBlock) {
        self.completionBlock(filter);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Picker View data source / delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.categoriesPickerView) {
        return self.categories.count + 1;
    } else if (pickerView == self.brandPickerView) {
        return self.brands.count + 1;
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        return @"";
    }
    
    if (pickerView == self.categoriesPickerView) {
        return self.categories[row - 1][@"name"];
    } else if (pickerView == self.brandPickerView) {
        return self.brands[row - 1][@"name"];
    }
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    if (pickerView == self.categoriesPickerView) {
        self.categoryTextField.text = text;
    } else if (pickerView == self.brandPickerView) {
        self.brandTextField.text = text;
    }
}

#pragma mark - Text Field delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"pt-BR"];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencyDecimalSeparator = @".";
    formatter.currencyGroupingSeparator = @"";
    formatter.currencySymbol = @"";
    formatter.maximumFractionDigits = 2;
    formatter.minimumFractionDigits = 2;
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    newString = [[newString componentsSeparatedByCharactersInSet:[NSCharacterSet decimalDigitCharacterSet].invertedSet] componentsJoinedByString:@""];
    textField.text = [formatter stringFromNumber:@(newString.integerValue / 100.f)];
    
    return NO;
}

@end
