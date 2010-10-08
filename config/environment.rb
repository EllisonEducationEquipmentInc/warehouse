# Load the rails application
require File.expand_path('../application', __FILE__)

# set to false if you want to use the app in 'warehouse' mode
#TRADESHOW = true 
TRADESHOW = false

# Initialize the rails application
Warehouse::Application.initialize!
