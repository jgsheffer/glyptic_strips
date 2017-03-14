require 'cucumber'
##
#
# Main class of Glyptic Strips
#

# = Setting up your project 
# 
# = Example
#
#   create_gif(sceanrio, './myproj/test_reports/screenshots', @browser, :watir, 6)
class GlypticStrips
    @@scenario_index = 0
    @@scenario_number = 0
    @@explicit_wait = 0
    @@red = '#C40D0D'
    @@green = '#65c400'
    @@divider = "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"

##
# This methods takes all of the png files from the parameter png_folder
# creates an html formatted string with them layed out in rows
#

    def create_strip(scenario, png_folder, driver, driver_type, number_in_row)
        @@scenario_index = 0
        final_strip =  ''
        take_strip_frame(driver, driver_type, png_folder) if(scenario.failed?)
        dir_contents = Dir.glob("#{png_folder}/scenario-#{@@scenario_number}-image-*.png").sort
        img_index = 0
        num_of_images = dir_contents.size
        scenario_index = get_correct_scenario_index(scenario)
        scenario_array = scenario.feature.feature_elements[scenario_index.to_i].send(:raw_steps).to_a
        # Add the step description in red or green text to each image frame
        dir_contents.each do |file_name|
            if(scenario_array[img_index] == nil)
                puts @@divider
                puts ":::::::::::::::::: There are more screenshots than steps :::::::::::::::::::::::::::::::::::::"
                puts "::::: Error :::::: Strips currently doesn't support background :::::::::::::::::::::::::::::::"
                puts ":::::::::::::::::: If you don't have backgrounds then clear our your screenshots dir :::::::::"
                puts @@divider
                puts "SCREENSHOTS DIR: #{png_folder} "
                raise 'There are more screenshots than steps.  Check console output for more details'
            end
            step_name = scenario_array[img_index].name.to_s
            if (scenario.failed? && (num_of_images - 1 == img_index))
                image_html = get_image_html(file_name, "#{img_index+1}: #{step_name}", @@red, number_in_row)
            else
                image_html = get_image_html(file_name, "#{img_index+1}: #{step_name}", @@green, number_in_row)
            end
            puts
            final_strip = final_strip+image_html
              if((img_index+1)%number_in_row == 0)
                final_strip = final_strip+'</br>'
            end
            img_index = img_index + 1

        end
        @@scenario_number = @@scenario_number + 1
        final_strip
    end

##
# Takes a screenshot and saves it as a single frame
# in the png_folder location
#
    def take_strip_frame(driver, driver_type, png_folder)
        if(driver_type == :appium)
            @@explicit_wait = 2
        end
        sleep @@explicit_wait
        @@scenario_index = 0 if @@scenario_index == nil
        screenshot_name = "%03d" % @@scenario_index
        screenshot_location = "#{png_folder}/scenario-#{@@scenario_number}-image-#{screenshot_name}.png"
        if(driver_type == :watir)
            driver.screenshot.save screenshot_location
        elsif(driver_type == :appium)
            driver.screenshot(screenshot_location)
        end
        @@scenario_index = @@scenario_index + 1
    end

##
# Helper method to get the correct text to add to the png file
#
    def get_correct_scenario_index(scenario)
        expected_name = scenario.name
        number_of_sceanrios = scenario.feature.feature_elements.size
        found = false
        current_iteration = 0
            while(!found && number_of_sceanrios > current_iteration) do
                if expected_name == scenario.feature.feature_elements[current_iteration].name
                    found = true
                else
                    current_iteration = current_iteration + 1
                end
            end
        current_iteration
    end

##
# Creates the image link and sets the color of the border
#
    def get_image_html(image_location, text, color, number_in_row)
        image_percent = 90/number_in_row
        "<a href='#{image_location}' title='#{text}'><img style='border:4px solid #{color}' width='#{image_percent}%' src='#{image_location}'/></a>"
    end
end