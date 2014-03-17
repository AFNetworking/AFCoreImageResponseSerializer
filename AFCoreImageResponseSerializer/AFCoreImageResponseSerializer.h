// AFCoreImageResponseSerializer.h
//
// Copyright (c) 2014 AFNetworking (http://afnetworking.com)
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

#import "AFURLResponseSerialization.h"

/**
 `AFCoreImageResponseSerializer` is a subclass of `AFImageResponseSerializer` that applies a set of Core Image filters to response images.
 */
@interface AFCoreImageResponseSerializer : AFImageResponseSerializer

/**
 The Core Image filters applied by the serializer.
 */
@property (readonly, nonatomic, strong) NSArray *filters;

/**
 Creates and returns a serializer with the specified Core Image filters.
 */
+ (instancetype)serializerWithFilters:(NSArray *)filters;

/**
 Creates and returns a serializer with the specified Core Image filters, and `CIContext` options.
 
 @param filters The Core Image filters to be applied
 @param options The options passed to the `CIContext`
 */
+ (instancetype)serializerWithFilters:(NSArray *)filters
                              options:(NSDictionary *)options;

@end
