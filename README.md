# README

**Overview**

Car Rental Application - Pack Rider
(Supported with Google Chrome Browser)
Note: Please go through the navigation links below for clear idea.

**How to Use Pack Rider:**

Preconfiged Super Admin: email: sysadmin@ncsu.edu, password: admin
Preconfiged Admin: email: admin@ncsu.edu, password: admin123

Please don't delete the admin or change the passwords for admin/superadmin.
If you want to test the update profile, revert it back to the old password after testing the feature or create a new admin or super admin and test using that profile

**Corner Cases**

1. Car Deletion:

    a. If the car is checked out:
       Admin will not be able to delete the car if its checked out.
       
    b. If the car has reservations:
       Admin will be able to delete the car and the corresponding reservations will be removed from the history of the user.
2. User Deletion:

    a. If the user has a checkedout car:
       Admin will not be able to delete the user if the user has checked out a car.         
       
    b. If the user has reservation:
       Admin will be able to delete the user and the corresponding reservation will be deleted from the history
       
    c. If the user has neither reservation or checked out car
        Admin can delete the user and corresponding history will also be deleted. 
  
This can be verified by viewing the history for car: Car index -> Show -> View History
For user: Home -> List Members -> View History
         
**Automatic Jobs**

Reservation will be automatically deleted if the user doesn't checkout the reserved car within 30 minutes of given time

If the user doesn't return the car within the given time, the car status will automatically change to available and the user will get a mail regarding the change of status

**Notification**

Customer can register for a car which is checkedout by clicking Notify in the cars index
Customer will get a mail if he registers for a checked out car and if the car becomes available
(Please use a valid email address to verify the functionality)

**Suggestions**

User can create a suggestion from the Home page.

Admin can approve or delete the suggestion.

Before approving, the admin can edit or add more details and once the suggestion is approved, the car is added to the car list.

**Super Admin**

Login as super admin:

Home Page -> Login super admin

Create new super admins:

Home page -> New Super Admin

View list of super admins/admins/members:

Home page -> List members

**Admin**

Login as admin:

Home Page -> Login admin

Creating a new admin:

Home Page -> Login admin -> In the Cars Index page -> New Admin

Note: Email mush be unique and in correct form

Edit profile:

Home page -> Profile

Viewing all admins:

Home page -> List members

Delete admins:

Home page -> List members -> Find the admin to be deleted and click Delete

Creating a new car:

Home page -> New car

View the attributes of a car:

Home page -> Find the car to be viewed and click Show

Edit the attributes of a car:

Home page -> Find the car to be edited and click Edit

View the checked out history of a car:

Home page -> Find the car and click Show -> View History

Delete a car:

Home page -> Find the car to be deleted and click Delete

View all customers:

Home page -> List members

View the history of a customer:

Home page -> List members -> Find the member and click View history

Edit Reservation:

Home page -> List members -> Find the member and click view history -> Cancel reservation/Edit reservation for a user

**Members**

Signup as a member:

Home Page -> Sign Up now

Login as a member:

Home Page -> Login member

View their own history:

Home -> Profile -> View History

Edit profile:

Home page -> Profile

Search for a car:

In the Home page -> Enter any information about the car in search field -> Click Search

View the attributes of a car:

Home -> Find the car and click Show

Reserve a car:

Home -> Find the car and click Reserve -> Enter From and To Details -> Reserve

Checkout a car:

Home -> Find the car and click checkout -> Enter To Details -> Checkout

**Testing**

Members model, members controller, cars model, cars controller are tested