import datetime
import csv
import re



def client_input():
    print("To create a contact, Please choose : 1 ")
    print("To update a contact, Please choose : 2 ")
    print("To delete a contact, Please choose : 3 ")
    user_input = int(input("Please enter your Choice: "))
    match user_input:
      case 1 :
          Create_Contact()
      case 2 :
          Update_Contact()
      case 3 :
          Delete_Contact()
      case _:
          print("Please choose from 1, 2 and 3:")
          client_input()


def Create_Contact():
    Name = input("Please, enter your name:")
    Email = emailValidator()
    Phone_Number = phoneNumberValidator()
    Address = input("Please enter your address: ")
    insertion_date = datetime.datetime.now().strftime('%d-%m-%Y- %H:%M:%S')
    save_inputs(Name, Email, Phone_Number, Address, insertion_date)
    client_input()

def Update_Contact():
    updated_text = update()
    search_email = input("what is the email of the user you want to update his data?")

    with open('data.csv', 'r') as file:
        reader = csv.reader(file)
        rows = list(reader)

    if emailFound(rows, search_email):
        for row in rows:
            if row[1] == search_email:
                if int(updated_text) == 1:
                    updatedValue = input("Please add new Name: ")
                    row[0] = updatedValue
                elif int(updated_text) == 2:
                    updatedValue = input("Please add new Email: ")
                    row[1] = updatedValue
                elif int(updated_text) == 3:
                    print("Please add new Phone Number ")
                    updatedValue = phoneNumberValidator()
                    row[2] = updatedValue
                elif int(updated_text) == 4:
                    updatedValue = input("Please add new Address: ")
                    row[3] = updatedValue
                elif int(updated_text) == 5:
                    client_input()
        with open('data.csv', 'w', newline='') as file:
            writer = csv.writer(file)
            writer.writerows(rows)
        print("The Update has been done successfully")
        client_input()
    else:
        print("Can't find this email, Please enter a valid one to search for:")
        Update_Contact()

def Delete_Contact():
    search_email = input("Please enter the email of client to be deleted: ")

    with open('data.csv', 'r') as file:
        reader = csv.reader(file)
        rows = list(reader)
    for row in rows:
        if row[1] == search_email:
            validation = 1
            break
        else:
            validation = 0
    if validation == 1:
        for row in rows:
            if row[1] == search_email:
                rows.remove(row)
                with open('data.csv', 'w', newline='') as file:
                    adder = csv.writer(file)
                    adder.writerows(rows)
                print("The Deletion has been done successfully")
                client_input()

    else:
        print("This Email doesn't exist in the file !")
        client_input()


def save_inputs(Name, Email, Phone_Number, Address, insertion_date):
    with open('data.csv', 'a', newline='') as file:
        adder = csv.writer(file)
        adder.writerow([Name, Email, Phone_Number, Address, insertion_date])
    print("Data was successfully added!")

def update():
    while True:
        field = input("What do you want to update:\n"
                 "1.  Name\n"
                 "2.  Email\n"
                 "3.  Phone_Number\n"
                 "4.  Address\n"
                 "5.  Getback to change the request\n"
                 "Enter the field number: ")
        if field.isdigit() and 0 < int(field) <= 5:
            if int(field) < 5:
                return field
            elif int(field) == 5:
                client_input()
        else:
            print("Please enter a number.")


def emailFound(rows, email):
    for row in rows:
        if row[1] == email:
            return True
    return False

#Validators for Phone Number and Email:
def phoneNumberValidator():
    while True:
        Phone_Number = input(" Please, enter your phone number: ")
        if Phone_Number.isdigit():
            return Phone_Number
        else:
            print("This is Invalid phone number, please try again.")

# Make a regular expression
# for validating an Email
regex = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,7}\b'
def emailValidator():
    while True:
        email = input(" Please, enter your email: ")
        if(re.fullmatch(regex, email)):
            return email
        else:
            print("This is Invalid email, please try again.")


if __name__ == '__main__':
    print("Please select your choice :")
    client_input()