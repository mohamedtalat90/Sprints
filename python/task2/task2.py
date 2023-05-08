#  function to check the leap year
def leap(year):
  # applying the logic to check if it leap year or not
  if((year % 400 == 0) or
     (year % 100 != 0) and
     (year % 4 == 0)):

    print("Year provided is a leap Year.")

  else:
    print ("Year provided is not a leap Year.")
# input data
year = int(input("Enter the Year: "))
#calling the function
leap(year) 
