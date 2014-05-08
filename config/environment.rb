# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Customers::Application.initialize!


# Define to_s(Original format)
Time::DATE_FORMATS[:default] = "%Y/%m/%d %H:%M:%S"
Time::DATE_FORMATS[:multiline] = "%Y/%m/%d<br />%H:%M:%S"