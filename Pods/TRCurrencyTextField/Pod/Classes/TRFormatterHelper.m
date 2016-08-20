//  TRFormatterHelper.m
//  Thiago Rossener ( https://github.com/thiagoross/TRCurrencyTextField )
//
//  Copyright (c) 2015 Rossener ( http://www.rossener.com/ )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "TRFormatterHelper.h"

@implementation TRFormatterHelper

static TRFormatterHelper *_self = nil;

#pragma mark - Public methods

+ (id)sharedInstance
{
    if (!_self) {
        _self = [TRFormatterHelper new];
    }
    return _self;
}

- (NSString *)stringFormattedFromValue:(NSNumber *)value withCurrencyCode:(NSString *)currencyCode
{
    NSArray *locales = [[TRLocaleHelper sharedInstance] allLocalesForCurrencyCode:currencyCode];
    NSAssert((locales != nil), @"Currency code passed as parameter is not valid.");
    
    NSNumberFormatter *numberFormatter = [[TRFormatterHelper sharedInstance] currencyFormatterForLocale:[locales firstObject]];
    
    [[TRFormatterHelper sharedInstance] addWhitespaceBetweenSymbolAndValue:numberFormatter];
    
    return [numberFormatter stringFromNumber:value];
}

- (NSNumber *)valueFromStringFormatted:(NSString *)stringFormatted andCurrencyCode:(NSString *)currencyCode
{
    NSArray *locales = [[TRLocaleHelper sharedInstance] allLocalesForCurrencyCode:currencyCode];
    NSAssert((locales != nil), @"Currency code passed as parameter is not valid.");
    
    NSNumberFormatter *numberFormatter = [[TRFormatterHelper sharedInstance] currencyFormatterForLocale:[locales firstObject]];
    
    NSString *textFieldStr = [NSString stringWithFormat:@"%@", stringFormatted];
    
    NSMutableString *textFieldStrValue = [NSMutableString stringWithString:textFieldStr];
    
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.currencySymbol
                                       withString:@""
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.groupingSeparator
                                       withString:@""
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    [textFieldStrValue replaceOccurrencesOfString:numberFormatter.decimalSeparator
                                       withString:@""
                                          options:NSLiteralSearch
                                            range:NSMakeRange(0, [textFieldStrValue length])];
    
    NSDecimalNumber *textFieldTextNum = [NSDecimalNumber decimalNumberWithString:textFieldStrValue];
    NSDecimalNumber *divideByNum = [[[NSDecimalNumber alloc] initWithInt:10] decimalNumberByRaisingToPower:numberFormatter.maximumFractionDigits];
    NSDecimalNumber *textFieldTextNewNum = [textFieldTextNum decimalNumberByDividingBy:divideByNum];
    
    return textFieldTextNewNum;
}

- (NSNumberFormatter *)currencyFormatterForCountryCode:(NSString *)countryCode
{
    if (!countryCode) {
        return nil;
    }
    
    NSLocale *locale = [[TRLocaleHelper sharedInstance] localeForCountryCode:countryCode];
    return [self currencyFormatterForLocale:locale];
}

- (NSNumberFormatter *)currencyFormatterForCurrencyCode:(NSString *)currencyCode
{
    if (!currencyCode) {
        return nil;
    }
    
    NSLocale *locale = [[TRLocaleHelper sharedInstance] localeForCurrencyCode:currencyCode];
    
    return [self currencyFormatterForLocale:locale];
}

- (NSNumberFormatter *)currencyFormatterForLocale:(NSLocale *)locale
{
    if (!locale) {
        return nil;
    }
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setMinimumFractionDigits:2];
    [numberFormatter setLocale:locale];
    
    return numberFormatter;
}

- (void)addWhitespaceBetweenSymbolAndValue:(NSNumberFormatter *)numberFormatter
{
    // symbol on left
    if ([numberFormatter.positiveFormat rangeOfString:@"\u00a4"].location < numberFormatter.positiveFormat.length/2) {
        [numberFormatter setCurrencySymbol:[NSString stringWithFormat:@"%@ ", [numberFormatter currencySymbol]]];
    }
    // symbol on right
    else {
        [numberFormatter setCurrencySymbol:[NSString stringWithFormat:@" %@", [numberFormatter currencySymbol]]];
    }
}

@end
