//
//  SwiftyDatesTests.swift
//  SwiftyDatesTests
//
//  Created by Ralph Küpper on 3/8/18.
//  Copyright © 2018 Skelpo Inc. All rights reserved.
//

@testable import SwiftyDates
import XCTest

struct TestCase {
    var input: String
    var output: String?

    init(_ i: String, _ o: String?) {
        self.input = i
        self.output = o
    }
}

class SwiftyDatesTests: XCTestCase {
    // ISO 8601 Test Cases
    var iso8601TestCases: [TestCase] = []
    // Common Date Test Cases (US, DE, GB)
    var dateTestCases: [TestCase] = []
    // Common Time Test Cases (US, DE, GB)
    var timeTestCases: [TestCase] = []
    // Common Time Test Cases (US, DE, GB)
    var datetimeTestCases: [TestCase] = []

    override func setUp() {
        super.setUp()

        let currentYear = Calendar.current.component(.year, from: Date())

        self.iso8601TestCases.append(TestCase("2018-03-08", "03/08/2018 00:00:00"))
        self.iso8601TestCases.append(TestCase("2018-03-08T15:49:46+00:00", "03/08/2018 15:49:46"))
        self.iso8601TestCases.append(TestCase("2018-03-08T15:49:46Z", "03/08/2018 15:49:46"))
        self.iso8601TestCases.append(TestCase("2018-03-08T15:49:46.4242Z", "03/08/2018 15:49:46"))
        // iso8601TestCases.append(TestCase("20180308T154946Z", "03/08/2018 15:49:46"))
        // iso8601TestCases.append(TestCase("2018-W10", "03/08/2018 00:00:00"))
        self.iso8601TestCases.append(TestCase("2018-03", "03/01/2018 00:00:00"))
        self.iso8601TestCases.append(TestCase("2017", "01/01/2017 00:00:00"))
        self.iso8601TestCases.append(TestCase("2017-06-03T17:15:04Z", "06/03/2017 17:15:04"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06.007", "02/03/2001 04:05:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06", "02/03/2001 04:05:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05", "02/03/2001 04:05:00"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06.007Z", "02/03/2001 04:05:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06.007", "02/03/2001 04:05:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06-00:00", "02/03/2001 04:05:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06-06:30", "02/03/2001 10:35:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06.007+06:30", "02/02/2001 21:35:06"))
        self.iso8601TestCases.append(TestCase("2001-02-03T04:05:06.007-06:30", "02/03/2001 10:35:06"))
        self.iso8601TestCases.append(TestCase("2020-01-16T08:34:00Z", "01/16/2020 08:34:00"))
        self.iso8601TestCases.append(TestCase("Tue, 17 Oct 2023 21:46:34 -0400", "10/17/2023 17:46:34"))
        self.iso8601TestCases.append(TestCase("Wed, 18 Oct 2023 11:56:11 +0200", "10/18/2023 09:56:11"))

        // Text dates
        self.datetimeTestCases.append(TestCase("Fri, 15 Jan 2021 13:22:00 -0500", "01/15/2021 08:22:00"))

        // DE (German) dates
        self.dateTestCases.append(TestCase("10.12.2017", "12/10/2017 00:00:00"))
        self.dateTestCases.append(TestCase("10.12.17", "12/10/2017 00:00:00"))
        self.dateTestCases.append(TestCase("10.12", "12/10/\(currentYear) 00:00:00"))
        self.dateTestCases.append(TestCase("12.2017", "12/01/2017 00:00:00")) // uncommon but we still support it
        // EN (GB etc.)
        self.dateTestCases.append(TestCase("10-12-2017", "12/10/2017 00:00:00"))
        self.dateTestCases.append(TestCase("10-12-17", "12/10/2017 00:00:00"))
        self.dateTestCases.append(TestCase("10-12", "12/10/\(currentYear) 00:00:00"))
        self.dateTestCases.append(TestCase("12-2017", "12/01/2017 00:00:00"))
        // US
        self.dateTestCases.append(TestCase("12/10", "10/12/\(currentYear) 00:00:00"))
        self.dateTestCases.append(TestCase("12/2017", "12/01/2017 00:00:00"))
        self.dateTestCases.append(TestCase("12/10/2017", "10/12/2017 00:00:00"))
        self.dateTestCases.append(TestCase("12/10/17", "10/12/2017 00:00:00"))
        self.dateTestCases.append(TestCase("15/01/2021", "01/15/2021 00:00:00"))

        self.timeTestCases.append(TestCase("13:37:42", "01/01/2018 13:37:42"))
        self.timeTestCases.append(TestCase("13:37", "01/01/2018 13:37:00"))
        self.timeTestCases.append(TestCase("1:13:37pm", "01/01/2018 13:13:37"))
        self.timeTestCases.append(TestCase("1:13:37 pm", "01/01/2018 13:13:37"))
        self.timeTestCases.append(TestCase("1:13:37.4242pm", "01/01/2018 13:13:37"))
        self.timeTestCases.append(TestCase("1:13", "01/01/2018 01:13:00"))
        self.timeTestCases.append(TestCase("1:13:37", "01/01/2018 01:13:37"))
        self.timeTestCases.append(TestCase("10:10", "01/01/2018 10:10:00"))
        self.timeTestCases.append(TestCase("10:10am", "01/01/2018 10:10:00"))
        self.timeTestCases.append(TestCase("10:10 am", "01/01/2018 10:10:00"))
        self.timeTestCases.append(TestCase("10:10pm", "01/01/2018 22:10:00"))
        self.timeTestCases.append(TestCase("10:10 pm", "01/01/2018 22:10:00"))
        self.timeTestCases.append(TestCase("10.10am", "01/01/2018 10:10:00"))
        self.timeTestCases.append(TestCase("10.10 am", "01/01/2018 10:10:00"))
        self.timeTestCases.append(TestCase("10.10pm", "01/01/2018 22:10:00"))
        self.timeTestCases.append(TestCase("10.10 pm", "01/01/2018 22:10:00"))
        self.timeTestCases.append(TestCase("10am", "01/01/2018 10:00:00"))
        self.timeTestCases.append(TestCase("", nil))

        self.datetimeTestCases.append(TestCase("10/12/2018 10am", "12/10/2018 10:00:00"))
        self.datetimeTestCases.append(TestCase("10/12/2018 10:30am", "12/10/2018 10:30:00"))
        self.datetimeTestCases.append(TestCase("10/12/2018 10:25pm", "12/10/2018 22:25:00"))
        self.datetimeTestCases.append(TestCase("12.10.2018 9:20", "10/12/2018 09:20:00"))
        self.datetimeTestCases.append(TestCase("12/25/2016 3:45pm", "12/25/2016 15:45:00"))
        self.datetimeTestCases.append(TestCase("20.10.2018 23:10", "10/20/2018 23:10:00"))
        self.datetimeTestCases.append(TestCase("2020-08-01T04:00:00.470Z", "08/01/2020 04:00:00"))
    }

    override func tearDown() {
        super.tearDown()
        self.iso8601TestCases.removeAll()
        self.dateTestCases.removeAll()
        self.timeTestCases.removeAll()
    }

    func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "America/New_York")
        return dateFormatter
    }

    func testIsoCases() {
        let dateFormatter = self.getDateFormatter()
        for tc in self.iso8601TestCases {
            let date: Date? = tc.input.swiftyDateTime()
            if date == nil {
                XCTAssertNil(tc.output)
            } else {
                let formatedDate = dateFormatter.string(from: date!.addingTimeInterval(60 * 60 * 6))
                XCTAssertEqual(formatedDate, tc.output)
            }
        }
    }

    func testDateCases() {
        let dateFormatter = self.getDateFormatter()
        for tc in self.dateTestCases {
            let date: Date? = tc.input.swiftyDate()
            if date == nil {
                XCTAssertNil(tc.output)
            } else {
                let formatedDate = dateFormatter.string(from: date!.addingTimeInterval(60 * 60 * 6))
                XCTAssertEqual(formatedDate, tc.output)
            }
        }
    }

    func testDateTimeCases() {
        let dateFormatter = self.getDateFormatter()
        for tc in self.datetimeTestCases {
            let date: Date? = tc.input.swiftyDateTime()
            if date == nil {
                XCTAssertNil(tc.output)
            } else {
                let formatedDate = dateFormatter.string(from: date!.addingTimeInterval(60 * 60 * 6))
                XCTAssertEqual(formatedDate, tc.output)
            }
        }
    }

    func testTimeCases() {
        let dateFormatter = self.getDateFormatter()
        let testDate: Date = DateComponents(calendar: Calendar.current, year: 2018, month: 1, day: 1).date!

        for tc in self.timeTestCases {
            // print("Parsing: ", tc.input, tc.output)
            let date: Date? = tc.input.swiftyDateTime(calendar: Calendar.current, baseDate: testDate)
            // print("we got: ",dateFormatter.string(from: date!))
            if date == nil {
                XCTAssertNil(tc.output)
            } else {
                let formatedDate = dateFormatter.string(from: date!.addingTimeInterval(60 * 60 * 6))
                XCTAssertEqual(formatedDate, tc.output)
            }
        }
    }

    func testDateTimePerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            _ = "2018-03-08T15:49:46+00:00".swiftyDateTime()
        }
    }

    func testManualPerformance() {
        let startTime = CFAbsoluteTimeGetCurrent()
        let cycles = 10000
        let dateString = "2018-03-08T15:49:46"

        for _ in 1 ... cycles {
            _ = dateString.swiftyDateTime()
        }
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(cycles) cycles: \(timeElapsed) s.")
        let perCall = timeElapsed / Double(cycles)
        print("That is: \(perCall) s for one swiftyDateTime() call.")

        print("Comparing that to the DateFormatter...")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")

        let startTime2 = CFAbsoluteTimeGetCurrent()
        for _ in 1 ... cycles {
            formatter.date(from: dateString)
        }
        let timeElapsed2 = CFAbsoluteTimeGetCurrent() - startTime2
        print("Time elapsed for \(cycles) cycles: \(timeElapsed2) s.")
        let perCall2 = timeElapsed2 / Double(cycles)
        print("That is: \(perCall2) s for one DateFormatter() call.")
        let faster = perCall - perCall2
        print("DateFormatter is \(faster) fast than SwiftyDates.")
    }

    func testTimePerformance() {
        self.measure {
            _ = "2018-03-08".swiftyDate()
        }
    }
}
