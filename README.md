# SwiftyDates - String to Date Conversions done the right way

Dealing with dates and times can be a pain. This project is an attempt to make it a little but less painful. This library is by no means complete or in a state where it can be used without ever worrying about it, however it should make life much less painful when it comes to dealing with dates in different formats.

## Why you need it?

Even when you get dates in a format like ISO 8601 things get messy really quickly. Mainly because ISO 8601 is not as static is Swift would like it. For example, take a date in ISO 8601 like `2018-03-08T15:49:46Z`. To parse this in string in Swift looks like this
```swift
let dateString = "2018-03-08T15:49:46Z"
let dateFormatter = DateFormatter()
dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
dateFormatter.dateFormat = "YYYYMMdd'T'HHmmss'Z'"
let date:Date? = dateFormatter.string(from: dateString) // this will work.
```
So far so good. Now, if we instead get another date, say:  `2018-03-08T15:49:46.5+03:30` Now Swift will throw you an exception because the specified format `YYYYMMdd'T'HHmmss'Z'`does not fit anymore.

```swift
let dateString = "2018-03-08T15:49:46.5+03:30"
let dateFormatter = DateFormatter()
dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
dateFormatter.dateFormat = "YYYYMMdd'T'HHmmss'Z'"
let date:Date = dateFormatter.string(from: dateString) // this will not work.
```

With _SwiftyDates_ all you need to do is this:
```swift
let dateString = "2018-03-08T15:49:46Z"
let date:Date? = dateString.swiftyDateTime() // this will work
```
Likewise the other date will work too:
```swift
let dateString = "2018-03-08T15:49:46.5+03:30"
let date:Date = dateString.swiftyDateTime() // this will work
```

## Dates

For dates you can use:
```swift
let dateString = "2018-03-08"
let date:Date = dateString.swiftyDate() // this will work
```

## Times

For dates you can use:
```swift
let dateString = "9:30am"
let date:TimeInterval = dateString.swiftyTime() // this will work
```

## Examples

The beauty of this library is that it will also understand other formats, for example:
```
10.12.2017
12:30
12/25/2016
```

Or in combinations:
```
12/25/2016 3:45pm
20.10.2018 23:10
```

## Assumptions
1. Humans are messy and unstructured. Dates are mostly entered because of humans. Consequently we are dealing with a mess and try to get the best of out of it.
1. Focussed on practical uses
2. Years are always given in 4 digits or in combination with months and days
3. Time without dates is an number in seconds from the beginning of the day
4. Dates without times have the time 00:00:00 (hh-mm-ss)
5. We are not throwing exceptions, if a date/time does not work _nil_ is returned.

## Limitations / Todo
1. No support for ordinal dates
2. No support for week days
3. No support for text dates ("November 2nd, 1991")

## Performance
First initial tests have shown that _SwiftyDates_ is about half as fast as DateFormatter. Considering the added functionality and flexibility it seems like a fair trade off. More performance tests should be performed and the code further optimized though.
