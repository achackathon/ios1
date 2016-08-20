//  LocaleHelper.m
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

#import "TRLocaleHelper.h"

@implementation TRLocaleHelper

static TRLocaleHelper *_self = nil;
static NSMutableDictionary *_currencyCodeCountryCodeMap = nil;
static NSMutableDictionary *_currencyCodeLocaleMap = nil;
static NSMutableDictionary *_countryCodeLocaleMap = nil;

#pragma mark - Superclass methods

- (id)init
{
    self = [super init];
    if (self) {
        [self fillCurrencyCodeCountryCodeMap];
        [self fillCurrencyCodeLocaleMap];
        [self fillCountryCodeLocaleMap];
    }
    return self;
}

#pragma mark - Public methods

+ (id)sharedInstance
{
    if (!_self) {
        _self = [TRLocaleHelper new];
    }
    return _self;
}

- (NSLocale *)localeForCountryCode:(NSString *)countryCode
{
    NSDictionary *components = [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
    NSString *localeIdentifier = [NSLocale localeIdentifierFromComponents:components];
    
    if (localeIdentifier != nil && [_countryCodeLocaleMap objectForKey:countryCode]) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
        return locale;
    }
    
    return nil;
}

- (NSLocale *)localeForCurrencyCode:(NSString *)currencyCode
{
    NSDictionary *components = [NSDictionary dictionaryWithObject:currencyCode forKey:NSLocaleCurrencyCode];
    NSString *localeIdentifier = [NSLocale localeIdentifierFromComponents:components];
    
    if (localeIdentifier != nil && [_currencyCodeLocaleMap objectForKey:currencyCode]) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
        return locale;
    }
    
    return nil;
}

- (NSArray *)allLocalesForCountryCode:(NSString *)countryCode
{
    if (!countryCode) {
        return nil;
    }
    
    return [_countryCodeLocaleMap objectForKey:countryCode];
}

- (NSArray *)allLocalesForCurrencyCode:(NSString *)currencyCode
{
    if (!currencyCode) {
        return nil;
    }
    
    return [_currencyCodeLocaleMap objectForKey:currencyCode];
}

- (NSString *)currencyCodeForCountryCode:(NSString *)countryCode
{
    if (!countryCode) {
        return nil;
    }
    
    NSDictionary *components = [NSDictionary dictionaryWithObject:countryCode forKey:NSLocaleCountryCode];
    NSString *localeIdentifier = [NSLocale localeIdentifierFromComponents:components];
    
    if (localeIdentifier != nil) {
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:localeIdentifier];
        return [locale objectForKey: NSLocaleCurrencyCode];
    }
    
    return nil;
}

- (NSArray *)countryCodesForCurrencyCode:(NSString *)currencyCode
{
    if (!currencyCode) {
        return nil;
    }
    
    return [_currencyCodeCountryCodeMap objectForKey:currencyCode];
}

#pragma mark - Private methods

- (void)fillCurrencyCodeCountryCodeMap
{
    _currencyCodeCountryCodeMap = [NSMutableDictionary new];
    
    for (NSString *identifier in [NSLocale availableLocaleIdentifiers]) {
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:identifier];
        NSString *currencyCode = [locale objectForKey:NSLocaleCurrencyCode];
        NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
        
        NSMutableArray *countryCodeArray = nil;
        
        if (currencyCode != nil) {
            if ([_currencyCodeCountryCodeMap objectForKey:currencyCode]) {
                countryCodeArray = [_currencyCodeCountryCodeMap objectForKey:currencyCode];
                
                if (![countryCodeArray containsObject:countryCode]) {
                    [countryCodeArray addObject:countryCode];
                }
            } else {
                countryCodeArray = [NSMutableArray new];
                [countryCodeArray addObject:countryCode];
            }
            [_currencyCodeCountryCodeMap setObject:countryCodeArray forKey:currencyCode];
        }
    }
}

- (void)fillCurrencyCodeLocaleMap
{
    _currencyCodeLocaleMap = [NSMutableDictionary new];
    
    for (NSString *identifier in [NSLocale availableLocaleIdentifiers]) {
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:identifier];
        NSString *currencyCode = [locale objectForKey:NSLocaleCurrencyCode];
        
        NSMutableArray *localeArray = nil;
        
        if (currencyCode != nil) {
            if ([_currencyCodeLocaleMap objectForKey:currencyCode]) {
                localeArray = [_currencyCodeLocaleMap objectForKey:currencyCode];
            } else {
                localeArray = [NSMutableArray new];
            }
            
            [localeArray addObject:locale];
            [_currencyCodeLocaleMap setObject:localeArray forKey:currencyCode];
        }
    }
}

- (void)fillCountryCodeLocaleMap
{
    _countryCodeLocaleMap = [NSMutableDictionary new];
    
    for (NSString *identifier in [NSLocale availableLocaleIdentifiers]) {
        NSLocale *locale = [NSLocale localeWithLocaleIdentifier:identifier];
        NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
        
        NSMutableArray *localeArray = nil;
        
        if (countryCode != nil) {
            if ([_countryCodeLocaleMap objectForKey:countryCode]) {
                localeArray = [_countryCodeLocaleMap objectForKey:countryCode];
            } else {
                localeArray = [NSMutableArray new];
            }
            
            [localeArray addObject:locale];
            [_countryCodeLocaleMap setObject:localeArray forKey:countryCode];
        }
    }
}

@end
