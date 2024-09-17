# Fly4Life-Data-base

**Presentation:**
The project involves creating a relational database for Fly4Life, a company that conducts humanitarian flights. The goal is to efficiently manage the fleet of aircraft, pilots, and humanitarian missions, ensuring smooth operational functionality and data integrity.<br/>

![image](https://github.com/user-attachments/assets/54d607d3-8a0b-4bab-a971-16224918e654)
**General Technologies used:**  <br/>
Data Modeling and Normalization: <br/>
- 1NF (First Normal Form): All table attributes are atomic, meaning each field contains only one value. <br/>
- 2NF (Second Normal Form): Partial dependencies are eliminated, ensuring that all non-key attributes fully depend on the primary key.<br/>
- 3NF (Third Normal Form): Transitive dependencies are removed, organizing data into separate tables to avoid redundancies.<br/>
- BCNF (Boyce-Codd Normal Form): Data consistency is ensured by eliminating any violations of functional dependencies.<br/>

**Physical Data Model:** <br/>
Tables Created:<br/>
- Aircraft: Stores information about the manufacturer, model, registration, and operational status of each aircraft.<br/>
- Pilots: Manages data such as name, category (captain or co-pilot), career start date, and license validity.<br/>
- Missions: Details each mission, including the captain, co-pilot, aircraft used, and the destination.<br/>
- Destinations: Records mission destinations using airport codes.<br/>

**Entity-Relationship Diagram (ERD):** <br/>
An Entity-Relationship Diagram (ERD) was created to graphically represent the entities (aircraft, pilots, missions, destinations) and their relationships. The ERD facilitates the visualization of the database structure and ensures data integrity by organizing the relationships between the various tables.

**SQL Queries and Data Exploration:** <br/>
General SQL Commands Used:
- SELECT: Used to extract data from different tables, combining information about pilots, missions, aircraft, and destinations.
- JOIN (INNER and LEFT JOIN): Used to combine data from multiple tables. For example, a LEFT JOIN was used to list all captains, even those not yet assigned to any mission.
- CREATE TABLE: Command used to define the tables in the database, specifying attributes, data types, and relationships via foreign keys (FOREIGN KEY) to ensure referential integrity.

**Example Table Structure:** <br/>
- The Pilots table includes fields such as Name, Category, Career Start Date, and License Validity.
- The Missions table references an aircraft and a pilot via foreign keys, ensuring that each mission is correctly linked to an aircraft and its crew.

  UPDATE: Used to update information in the database, such as promoting co-pilots to captain positions, thus maintaining the career progression of the pilots.
Queries to Verify Specific Conditions:
- SQL queries were run to check the availability of pilots and aircraft, as well as missions within specific time periods.
- A specific query was implemented to identify pilots whose licenses were approaching expiration, ensuring license validity control.


