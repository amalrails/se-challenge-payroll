
## Project Description

Imagine that this is the early days of history, and that we are prototyping a new payroll system API. A front end (that hasn't been developed yet, but will likely be a single page application) is going to use our API to achieve two goals:

1. Upload a CSV file containing data on the number of hours worked per day per employee
1. Retrieve a report detailing how much each employee should be paid in each _pay period_

All employees are paid by the hour (there are no salaried employees.) Employees belong to one of two _job groups_ which determine their wages; job group A is paid $20/hr, and job group B is paid $30/hr. Each employee is identified by a string called an "employee id" that is globally unique in our system.

Hours are tracked per employee, per day in comma-separated value files (CSV).
Each individual CSV file is known as a "time report", and will contain:

1. A header, denoting the columns in the sheet (`date`, `hours worked`,
   `employee id`, `job group`)
1. 0 or more data rows

In addition, the file name should be of the format `time-report-x.csv`,
where `x` is the ID of the time report represented as an integer. For example, `time-report-42.csv` would represent a report with an ID of `42`.

You can assume that:

1. Columns will always be in that order.
1. There will always be data in each column and the number of hours worked will always be greater than 0.
1. There will always be a well-formed header line.
1. There will always be a well-formed file name.

A sample input file named `time-report-42.csv` is included in this repo.

### What your API must do:

We've agreed to build an API with the following endpoints to serve HTTP requests:

1. An endpoint for uploading a file.

   - This file will conform to the CSV specifications outlined in the previous section.
   - Upon upload, the timekeeping information within the file must be stored to a database for archival purposes.
   - If an attempt is made to upload a file with the same report ID as a previously uploaded file, this upload should fail with an error message indicating that this is not allowed.

1. An endpoint for retrieving a payroll report structured in the following way:

   _NOTE:_ It is not the responsibility of the API to return HTML, as we will delegate the visual layout and redering to the front end. The expectation is that this API will only return JSON data.

   - Return a JSON object `payrollReport`.
   - `payrollReport` will have a single field, `employeeReports`, containing a list of objects with fields `employeeId`, `payPeriod`, and `amountPaid`.
   - The `payPeriod` field is an object containing a date interval that is roughly biweekly. Each month has two pay periods; the _first half_ is from the 1st to the 15th inclusive, and the _second half_ is from the 16th to the end of the month, inclusive. `payPeriod` will have two fields to represent this interval: `startDate` and `endDate`.
   - Each employee should have a single object in `employeeReports` for each pay period that they have recorded hours worked. The `amountPaid` field should contain the sum of the hours worked in that pay period multiplied by the hourly rate for their job group.
   - If an employee was not paid in a specific pay period, there should not be an object in `employeeReports` for that employee + pay period combination.
   - The report should be sorted in some sensical order (e.g. sorted by employee id and then pay period start.)
   - The report should be based on all _of the data_ across _all of the uploaded time reports_, for all time.

   As an example, given the upload of a sample file with the following data:

    <table>
    <tr>
      <th>
        date
      </th>
      <th>
        hours worked
      </th>
      <th>
        employee id
      </th>
      <th>
        job group
      </th>
    </tr>
    <tr>
      <td>
        2020-01-04
      </td>
      <td>
        10
      </td>
      <td>
        1
      </td>
      <td>
        A
      </td>
    </tr>
    <tr>
      <td>
        2020-01-14
      </td>
      <td>
        5
      </td>
      <td>
        1
      </td>
      <td>
        A
      </td>
    </tr>
    <tr>
      <td>
        2020-01-20
      </td>
      <td>
        3
      </td>
      <td>
        2
      </td>
      <td>
        B
      </td>
    </tr>
    <tr>
      <td>
        2020-01-20
      </td>
      <td>
        4
      </td>
      <td>
        1
      </td>
      <td>
        A
      </td>
    </tr>
    </table>

   A request to the report endpoint should return the following JSON response:

   ```javascript
   {
     payrollReport: {
       employeeReports: [
         {
           employeeId: 1,
           payPeriod: {
             startDate: "2020-01-01",
             endDate: "2020-01-15"
           },
           amountPaid: "$300.00"
         },
         {
           employeeId: 1,
           payPeriod: {
             startDate: "2020-01-16",
             endDate: "2020-01-31"
           },
           amountPaid: "$80.00"
         },
         {
           employeeId: 2,
           payPeriod: {
             startDate: "2020-01-16",
             endDate: "2020-01-31"
           },
           amountPaid: "$90.00"
         }
       ];
     }
   }
   ```

We consider ourselves to be language agnostic, so feel free to use any combination of technologies you see fit to both meet the requirements and showcase your skills. We only ask that your submission:

- Is easy to set up
- Can run on either a Linux or Mac OS X developer machine
- Does not require any non open-source software

### Documentation:

Instructions on how to build/run your application

Pre-requisites:
1. Latest version of git needs to be installed
2. Bundler gem with version 2.1.2

Run the following commands in your terminal:

1. git clone -b master /path/to/amal_subhash.bundle wave_payroll_app
1. cd /path/to/wave_payroll_app
1. rvm gemset create payroll_app
1. rvm gemset use payroll_app
1. Use rvm gemset list to verify (optional)
1. bundle install
1. Db-creation and migration:
   - bundle exec rake db:create db:schema:load db:seed
1. Running test-cases:
   - bundle exec rspec --format documentation
1. Starting the rails server
   - rails s -p 3000 (or any port number)
1. Open any browser and go to http://localhost:3000/
1. Use the import option to import a csv data file
1. Fetch the payroll report
   - go to http://localhost:3000/pay_rolls/fetch_payroll_report.json

Answers:
   - How did you test that your implementation was correct?
   - I wrote unit tests and tested using rspec, i also verified the functionality of the app manually.

   - If this application was destined for a production environment, what would you add or change?
   - If it was for production env i would have added the following:
     - Add request authentication and authorization(whitelist ip's, verify FQDN, API Key Authentication etc.)
     - User authentication and authorization(to prevent any malicious uploads).
     - Improve sanitization of imported data.
     - Make import data as a background job.
     - Use SSL
     - Optional: Restructure the way data is fetched for the payroll report generation(to provide better performance with bigger data volume).


   - What compromises did you have to make as a result of the time constraints of this challenge?
   - I had to make the following compromises:
     - Better design for the data models which can handle different types of reports(monthly, biweekly, quarterly etc), high volume of data and provide better performance for report generation.

     ps: I tried implementing it but had to revert back half way. I can explain in detail if you consider me for next round. ;)

     - User authentication and authorization.
     - Handle same employee in multiple groups problem.
     - Handle restricting to add same file_name properly(because though file name already exists in system, the latest upload can have different data's).
     - Make import data as a background job.
     - Index page for reports with pagination and search.
     - Better UX/UI.
     - Would have avoided the minor assumptions, that i had to make to avoid the delay in submission of this challenge(please check the Assumptions section).

Assumptions:
  1. If there are repeating employee_ids for same dates in multiple csv files, then it will get added in time_report_record table and in the report working hours for that date will be sum of all working hours.


## Submission Instructions

1. Clone the repository.
1. Complete your project as described above within your local repository.
1. Ensure everything you want to commit is committed.
1. Create a git bundle: `git bundle create your_name.bundle --all`
1. Email the bundle file to [dev.careers@waveapps.com](dev.careers@waveapps.com) and CC the recruiter you have been in contact with.

## Evaluation

Evaluation of your submission will be based on the following criteria.

1. Did you follow the instructions for submission?
1. Did you complete the steps outlined in the _Documentation_ section?
1. Were models/entities and other components easily identifiable to the
   reviewer?
1. What design decisions did you make when designing your models/entities? Are
   they explained?
1. Did you separate any concerns in your application? Why or why not?
1. Does your solution use appropriate data types for the problem as described?
