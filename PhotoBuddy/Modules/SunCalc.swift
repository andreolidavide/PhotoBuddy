//
//  SunCalc.swift
//  PhotoBuddy
//
//  Created by Davide Andreoli on 21/11/20.
//

import Foundation

struct AstronomicConstants {
    // Earth Perielion Ecliptic Longitude
    static let earthΠ = 102.9373
    // Obliquity of the equator of the planet compared to the orbit of the planet
    static let earthε = 23.4397
    // Sidereal time constants
    static let earthθ0 = 280.1470
    static let earthθ1 = 360.9856235
    // J2000 JDN for 1 january 2000
    static let j2000 = 2451545
    // Mean anomaly constants
    static let earthM0 = 357.5291
    static let earthM1 = 0.98560028
    // Equation of center constants (used in true anomaly calculation)
    static let earthC1 = 1.9148
    static let earthC2 = 0.0200
    static let earthC3 = 0.0003
    // Solar transit constants
    static let earthJ0 = 0.0009
    static let earthJ1 = 0.0053
    static let earthJ2 = -0.0068
    static let earthJ3 = 1.0000000
    // Sunrise and sunset constants
    static let earthH1 = 22.137
    static let earthH3 = 0.599
    static let earthH5 = 0.016
    static let earthh0 = -0.83
    static let dsun = 0.53
    static let sinh0 = -0.0146
    
}

func toJulianDateNumber(date: Date) -> Int {
    /* Convert a date in the Julian Date Number correspondant to it, using the following formula:
     JDN = (1461 × (Y + 4800 + (M − 14)/12))/4 + (367 × (M − 2 − 12 × ((M − 14)/12)))/12 − (3 × ((Y + 4900 + (M - 14)/12)/100))/4 + D − 32075
     
     Known issues: The input date is assumed to be in the gregorian calendar, otherwise the formula should be changed
     */
    // Decompose the input date in year month and day components
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
    // Calculate the terms separately
    let firstTerm = (1461 * (dateComponents.year! + 4800 + (dateComponents.month! - 14)/12))/4
    let secondTerm = (367 * (dateComponents.month! - 2 - 12 * ((dateComponents.month! - 14)/12)))/12
    let thirdTerm = (3 * ((dateComponents.year! + 4900 + (dateComponents.month! - 14)/12)/100))/4
    // Calculate the JDN
    let JDN = firstTerm + secondTerm - thirdTerm + dateComponents.day! - 32075
    
    return JDN
}

func toJulianDate(date: Date) -> Double {
    /* Convert a date in the Julian Date correspondant to it, using the following formula:
     JDN = (1461 × (Y + 4800 + (M − 14)/12))/4 + (367 × (M − 2 − 12 × ((M − 14)/12)))/12 − (3 × ((Y + 4900 + (M - 14)/12)/100))/4 + D − 32075
     
     JD = JDN + (hour - 12)/24 + minutes/1440 + seconds/86400
     
     Known issues: The input date is assumed to be in the gregorian calendar, otherwise the formula should be changed
     */
    // Call toJulianDateNumber to calculate the integer part
    let JDN = toJulianDateNumber(date: date)
    // Decompose the input date in hour minute and seconds components
    let calendar = Calendar.current
    let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
    // Calculate the terms separately
    let hourBit = Double((dateComponents.hour! - 12)) / 24
    let minutesBit = Double(dateComponents.minute!) / 1440
    let secondsBit = Double(dateComponents.second!) / 86400
    // Calculate the JD and round it to six decimal places
    var julianDate = Double(JDN) + hourBit + minutesBit + secondsBit
    julianDate = Double(round(1000000*julianDate)/1000000)
    
    return julianDate
}

func fromJDNtoGregorian(JDN: Int) -> DateComponents {
    /* Convert a JDN to the date its referring to, and return the results as a date component variable.
     The formula is:
     variable   value   variable    value
     y          4716    v           3
     j          1401    u           5
     m          2       s           153
     n          12      w           2
     r          4       B           274277
     p          1461    C           −38
     
     f = JDN + j + (((4 × JDN + B) div 146097) × 3) div 4 + C
     e = r × f + v
     g = mod(e, p) div r
     h = u × g + w
     D = (mod(h, s)) div u + 1
     M = mod(h div s + m, n) + 1
     Y = (e div p) - y + (n + m - M) div n
     */
    // Constant definitions and calculations
    let y = 4716
    let j = 1401
    let m = 2
    let n = 12
    let r = 4
    let p = 1461
    let v = 3
    let u = 5
    let s = 153
    let w = 2
    let B = 274277
    let C = -38
    let f = JDN + j + (((4 * JDN + B) / 146097) * 3) / 4 + C
    let e = r * f + v
    let g = mod(dividend: e, divisor: p) / r
    let h = u * g + w
    // Calculate the day, month and year
    let day = mod(dividend: h, divisor: s) / u + 1
    let month = mod(dividend: ((h/s)+m), divisor: n) + 1
    let year = (e/p) - y + (n + m - month) / n
    // Create a date components object and store the results
    var dateComponents = DateComponents()
    dateComponents.day = day
    dateComponents.month = month
    dateComponents.year = year
    
    return dateComponents
    
}

func fromJDtoGregorian(JD: Double) -> DateComponents {
    /* Convert a JD to the date and time its referring to, and return the results as a date component variable.
     The JD is first divided in the integer part (JDN) and decimal part.
     The JDN to year/month/day calculation is carried out by the dedicated funcion fromJDNtoGregorian, the decimal
     part is multiplied by 86400 to get the number of seconds, which are then added to the JDN date.
     */
    let calendar = Calendar.current
    // Divide integer and decimal part of JD
    let JDN = floor(JD)
    let remainder = JD.truncatingRemainder(dividingBy: 1)
    // Calculate the number of seconds to be added.
    let numberOfSeconds = remainder * 86400
    // Get the year/month/day part of the day with the dedicated function
    var dateComponents = fromJDNtoGregorian(JDN: Int(JDN))
    // Since the JDN is with reference to noon, 12:00 is set as the reference time to which the number of seconds will be added
    dateComponents.hour = 12
    dateComponents.minute = 0
    dateComponents.second = 0
    dateComponents.timeZone = TimeZone.current
    // Get the reference date as a date object
    let referenceDate = calendar.date(from: dateComponents)
    // get the final datetime by adding the number of seconds to the reference date
    let finalDate = referenceDate?.addingTimeInterval(numberOfSeconds)
    // get a date components object from the final date
    let newDateComponents = calendar.dateComponents([.hour, .minute, .second], from: finalDate!)
    // assign the final hour / minute / seconds to the dateComponents object
    dateComponents.hour = newDateComponents.hour!
    dateComponents.minute = newDateComponents.minute!
    dateComponents.second = newDateComponents.second!
    
    return dateComponents

}

func earthMeanAnomaly(JD: Double) -> Double {
    /* Calculate the earth mean anomaly using the formula:
     M = (M0 + M1 * (J -J2000)) mod 360°
     */
    // Calculate the term
    let term = (AstronomicConstants.earthM0 + AstronomicConstants.earthM1 * (JD - Double(AstronomicConstants.j2000)))
    // Return the remainder of the division by 360 to avoid having angles over 360 and rounded to the sixth decimal place
    let result = term.truncatingRemainder(dividingBy: 360)
    return Double(round(1000000*result)/1000000)

}

func earthTrueAnomaly(JD: Double) -> Double {
    /* Calculate the earth true anomaly (nu) using the formula:
     nu = M + C
     where C is calculated as
     C = C1sin(M) + C2sin(2M) + C3sin(3M) (other terms are zero because C4 C5 C6 are zero for earth)
     */
    // Calculate the mean anomaly
    let meanAnomaly = earthMeanAnomaly(JD: JD)
    // Calculate C; all angles are converted to the radian value by multiplying by pi / 180
    let equationOfCenter = (AstronomicConstants.earthC1 * sin(meanAnomaly * Double.pi / 180)) + (AstronomicConstants.earthC2 * sin((2 * meanAnomaly) * Double.pi / 180)) + (AstronomicConstants.earthC3 * sin((3 * meanAnomaly) * Double.pi / 180))
    let trueAnomaly = meanAnomaly + equationOfCenter
    
    let result = trueAnomaly.truncatingRemainder(dividingBy: 360)
    return Double(round(1000000*result)/1000000)
}

func earthMeanLongitude(JD: Double) -> Double {
    /* Calculate the earth mean longitude L using the formula:
     L = M + EarthPI
     */
    // Calculate M witht he dedicate function
    let M = earthMeanAnomaly(JD: JD)
    // Return the remainder of the division by 360 to avoid having angles over 360
    let result = (M + AstronomicConstants.earthΠ).truncatingRemainder(dividingBy: 360)
    return Double(round(1000000*result)/1000000)
        
    
}

func earthTrueLongitude(JD: Double) -> Double {
    /* Calculate the earth mean longitude L using the formula:
     L = nu + EarthPI
     */
    // Calculate nu with the dedicated function
    let nu = earthTrueAnomaly(JD: JD)
    // Return the remainder of the division by 360 to avoid having angles over 360
    let result = (nu + AstronomicConstants.earthΠ).truncatingRemainder(dividingBy: 360)
    return Double(round(1000000*result)/1000000)
        
}

func sunToEarthMeanLongitude(JD: Double) -> Double {
    /* Calculate the sun mean longitude Lsun using the formula:
     Lsun = L + 180
     */
    // Calculate L with the dedicated function
    let L = earthMeanLongitude(JD: JD)
    let sunL = L + 180
    // Return the remainder of the division by 360 to avoid having angles over 360
    return Double(round(1000000*sunL.truncatingRemainder(dividingBy: 360))/1000000)
        
}

func sunToEarthTrueLongitude(JD: Double) -> Double {
    /* Calculate the sun mean longitude Lsun using the formula:
     lambdSsun = lambda + 180
     */
    // Calculate lambda with the dedicated function
    let lambda = earthTrueLongitude(JD: JD)
    let sunLambda = lambda + 180
    // Return the remainder of the division by 360 to avoid having angles over 360
    return Double(round(1000000*sunLambda.truncatingRemainder(dividingBy: 360))/1000000)
        
}

func sunAscension(JD: Double) -> Double {
    /* Calculate the sun ascension alphaSun using the formula:
     alphaSun = arctan((sin(lambdaSun) * cos(earthEpsilon)) / cos(lambdaSun))
     */
    // Calculate lambdaSun with the dedicated function
    let lambda = sunToEarthTrueLongitude(JD: JD)
    // Compute numerator and denominator converting all angles to radian
    let numerator = sin(lambda * Double.pi / 180) * cos(AstronomicConstants.earthε * Double.pi / 180)
    let denominator = cos(lambda * Double.pi / 180)
    // Return the result, converting it to degrees by multiplying by 180 / Double.pi
    let result = atan((numerator/denominator)) * 180 / Double.pi
    return Double(round(1000000*result)/1000000)
   
}

func sunDeclination(JD: Double) -> Double {
    /* Calculate the sun declination deltaSun using the formula:
     deltaSun = arcsin((sin(lambdaSun) * sin(earthEpsilon))
     */
    // Calculate lambdaSun with the dedicated function
    let lambda = sunToEarthTrueLongitude(JD: JD)
    // Return the result, converting it to degrees by multiplying by 180 / Double.pi
    let result = asin(sin(lambda * Double.pi / 180) * sin(AstronomicConstants.earthε * Double.pi / 180)) * 180 / Double.pi
    return Double(round(1000000*result)/1000000)
}

func earthSiderealTime(JD: Double, longitude: Double) -> Double {
    /* Calculate the sidereal time theta for a given JDN at a given longitude with the formula
     theta = earthTheta0 + earthTheta1 * (J − J2000) - longitudeWest mod 360°
     */
    // Calculate theta
    let theta = AstronomicConstants.earthθ0 + AstronomicConstants.earthθ1 * (JD - Double(AstronomicConstants.j2000)) - (longitude * -1)
    // Return the remainder of the division by 360 to avoid having angles over 360
    let result = theta.truncatingRemainder(dividingBy: 360)
    return Double(round(1000000*result)/1000000)
}

func hourAngle(JD: Double, longitude: Double) -> Double {
    /* Calculate the hour angle of the sun for a given JDN at a given longitude using the formula
     H = theta - alpha
     */
    // Calculate theta using the dedicated function
    let theta = earthSiderealTime(JD: JD, longitude: longitude)
    // Calculate alpha using the dedicated function
    let alpha = sunAscension(JD: JD)
    
    var result = theta - alpha
    // Hour angle is expressed in range -180 < x < 180, therefore values greater than that should be taken care of
    if result > 180 {
        result = result - 360
    }
    return Double(round(1000000*result)/1000000)
}

func altitude(JD: Double, latitude: Double, longitude: Double) -> Double {
    /* Calculate the sun altitude for a given JDN at a given latitude and a given longitude using the formula
     h = arcsin((sin(latitude) * sin(declination)) + (cos(latitude) * cos(declination) * cos(H)))
     */
    // Calculate H using the dedicated function
    let H = hourAngle(JD: JD, longitude: longitude)
    // Calculate the declination using the dedicated function
    let delta = sunDeclination(JD: JD)
    // Calculate the two terms
    let firstTerm = sin(latitude * Double.pi / 180) * sin(delta * Double.pi / 180)
    let secondTerm = cos(latitude * Double.pi / 180) * cos(delta * Double.pi / 180) * cos(H * Double.pi / 180)
    
    let result = asin((firstTerm + secondTerm)) * 180 / Double.pi
    return Double(round(1000000*result)/1000000)
}

func azimuth(JD: Double, latitude: Double, longitude: Double) -> Double {
    /* Calculate the sun azimuth A for a given JDN at a given latitude and a given longitude using the formula
     A = arctan(sin(H) / (cos(H) * sin(latitude)) - (tan(delta) * cos(latitude)))
     */
    // Calculate H using the dedicated function
    let H = hourAngle(JD: JD, longitude: longitude)
    // Calculate the declination using the dedicated function
    let delta = sunDeclination(JD: JD)
    // calculate the terms
    let numerator = sin(H * Double.pi / 180)
    let denominator = cos(H * Double.pi / 180) * sin(latitude * Double.pi / 180) - tan(delta * Double.pi / 180) * cos(latitude * Double.pi / 180)
    let result = atan((numerator/denominator)) * 180 / Double.pi
    return Double(round(1000000*result)/1000000)
}

func solarTransit(JD: Double, latitude: Double, longitude: Double) -> Double {
    /* Calculate the solar transit nearest to the given JDN, expressed in JD, using the iterative method based on the following
     nx = (J - J2000 - EarthJ0) / (EarthJ3) - latitude / 360
     n = round(nx)
     Jx = J + EarthJ3 * (n - nx)
     Jtransit = Jx + J1 * sin(M) + J2 * sin(2Lsun)
     
     
     Jtransit = Jtransit - H / 360 * EarthJ3
     This last step is repeated until Jtransit doesn't change anymore
     */
    // Calculate sunL and M using the dedicated functions
    let sunL = sunToEarthMeanLongitude(JD: JD)
    let M = earthMeanAnomaly(JD: JD)
    // Calculate H using the dedicated funcion, storing it in a variable because later it will be changed
    var H = hourAngle(JD: JD, longitude: longitude)
    // calculate the equation terms
    let nx = ((JD - Double(AstronomicConstants.j2000) - AstronomicConstants.earthJ0) / AstronomicConstants.earthJ3) - longitude / 360
    let n = round(nx)
    let Jx = JD + AstronomicConstants.earthJ3 * (n - nx)
    var Jtransit = Jx + AstronomicConstants.earthJ1 * sin(M * Double.pi / 180) + AstronomicConstants.earthJ2 * sin(2 * sunL * Double.pi / 180)
    Jtransit = Jtransit - H / 360 * AstronomicConstants.earthJ3
    // Iterate over the iterative correction while H is different from 0
    while H != 0 {
        H = hourAngle(JD: Jtransit, longitude: longitude)
        Jtransit = Jtransit - H / 360 * AstronomicConstants.earthJ3
    }
    
    let result = Jtransit
    return Double(round(1000000*result)/1000000)
}

func sunriseSunsetHourAngle(JD: Double, latitude: Double) -> Double {
    let delta = sunDeclination(JD: JD)
    let numerator = AstronomicConstants.sinh0 - sin(latitude * Double.pi / 180) * sin(delta * Double.pi / 180)
    let denominator = cos(latitude * Double.pi / 180) * cos(delta * Double.pi / 180)
    let result = acos(numerator / denominator) * 180 / Double.pi
    return Double(round(1000000*result)/1000000)
}

func calculateSunset(JD: Double, latitude: Double, longitude: Double) -> Double {
    let Jtransit = solarTransit(JD: JD, latitude: latitude, longitude: longitude)
    var Ht = sunriseSunsetHourAngle(JD: JD, latitude: latitude)

    
    var Jset = Jtransit + (Ht / 360) * AstronomicConstants.earthJ3
    var H = hourAngle(JD: Jset, longitude: longitude)
    var newJset = Jset - ((H - Ht) / 360) * AstronomicConstants.earthJ3
    var oldJset = Jset
    
    while Jset != newJset {
        Ht = sunriseSunsetHourAngle(JD: newJset, latitude: latitude)
        H = hourAngle(JD: newJset, longitude: longitude)
        oldJset = newJset
        newJset = newJset - ((H - Ht) / 360) * AstronomicConstants.earthJ3
        Jset = oldJset
    }
    
    let result = Jset
    
    return Double(round(1000000*result)/1000000)
}

func calculateSunrise(JD: Double, latitude: Double, longitude: Double) -> Double {
    let Jtransit = solarTransit(JD: JD, latitude: latitude, longitude: longitude)
    var Ht = sunriseSunsetHourAngle(JD: JD, latitude: latitude)
    
    var Jrise = Jtransit - (Ht / 360) * AstronomicConstants.earthJ3
    var H = hourAngle(JD: Jrise, longitude: longitude)
    print(H)
    var newJrise = Jrise - ((H + Ht) / 360) * AstronomicConstants.earthJ3
    var oldJrise = Jrise
    
    while Jrise != newJrise {
        Ht = sunriseSunsetHourAngle(JD: newJrise, latitude: latitude)
        H = hourAngle(JD: newJrise, longitude: longitude)
        oldJrise = newJrise
        newJrise = newJrise - ((H + Ht) / 360) * AstronomicConstants.earthJ3
        Jrise = oldJrise

    }
    
    let result = Jrise
    
    return Double(round(1000000*result)/1000000)
}

// To calculate morning blue hour: calculate the angle at midday --> if its lower than 6° exit
// if not, calculate the angle at the half of the interval between JD and (JD-1).5, proceed iteratively
