#!/usr/bin/env python3

# display a welcome message
print("The Miles Per Gallon program")
print()

# get input from the user
miles_driven= float(input("Enter miles driven:\t\t"))
gallons_used = float(input("Enter gallons of gas used:\t"))
gallon_cost = float(input("Enter cost per gallon:\t\t"))

# calculate miles per gallon
mpg = round(miles_driven / gallons_used, 1)
# calculate total gallon cost
total_gallon_cost = round(gallon_cost * gallons_used, 1)
#calculate cost per mile
cost_per_mile = round(gallon_cost / mpg, 1)
            
# format and display the result
print()
print(f"Miles Per Gallon:\t\t{mpg}")
print(f"Total Gas Cost:\t\t\t{total_gallon_cost}")
print(f"Cost per Mile:\t\t\t{cost_per_mile}")
print()
print("Bye!")


