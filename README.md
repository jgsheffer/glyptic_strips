#Glyptic Strips - Cucumber Screenshot Creation and Formatting

## Description

Glyptic Strips is meant to be used in conjunction with cucumber to help generate formatted screenshots of test runs which can be embeded into reports

Curretly watir-webdriver and appium are the only supported drivers.
:appium
:watir

Backgrounds and scenario outlines are not fully supported

## Creating Strips
 
In your cucumber hooks file add the following
```ruby
  Before do
    if($glyptic_strips == nil)
      $glyptic_strips = GlypticStrips.new
    end
  end

  AfterStep do |scenario|
    $glyptic_strips.take_strip_frame($driver, :watir, Dir.pwd+"/test_reports/screenshots")
  end

  After do |scenario|
    timestamp = Time.now.to_s.gsub(/:/, '-')
    png_location = Dir.pwd+"/test_reports/screenshots"
    puts $glyptic_strips.create_strip(scenario, png_location, $driver, :watir, 6)
  end

```
## Warranty

This software is provided "as is" and without any express or implied
warranties, including, without limitation, the implied warranties of
merchantability and fitness for a particular purpose.