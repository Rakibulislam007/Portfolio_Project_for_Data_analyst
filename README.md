This is a Data analyst Portfolio project where i have used my gatherd knowledge about sql so far and put it onto hands on project.
The Process conists on mainly,
--Collecting the datasets
--Clean IT
--Normalizing the data
--Importing it to SQL server management studio
--visualizing it
--analise it
--making decesion from it.

In this Portfolio project i have used Basic, intermidiet and Little bit advance knowledge of SQL.
------------------------------------------------------------------------------------------------------
This Project covers a range of SQL concepts, including data retrieval, calculations, aggregation,
window functions, temporary tables, views, and common table expressions, all while adhering to best practices for readability and maintainability.

Here are more spacific of what i mean
--------------------------------------
Data Retrieval and Filtering:
-

The code demonstrates how to retrieve data from a table using the SELECT statement with various conditions,
such as filtering out records where the continent is NULL or specific country conditions like %Bangladesh%.

Calculating Percentages:
-

There are calculations for death percentage (DeathPercentage) and population infected percentage (populationInfectedPercentage).
These calculations show the likelihood of death and the percentage of the population infected, respectively.

Aggregation with GROUP BY:
-
The code uses the GROUP BY clause to aggregate data, such as finding the highest infection count to population ratio
and the highest death count per population for each location and continent.

Rolling Sum with Window Function:
-
A rolling sum is calculated using the SUM window function over a partition and ordered by date. 
This helps in tracking cumulative values over time (RollingPeopleVaccination).

Common Table Expressions (CTEs):
-
A Common Table Expression (CTE) named PopvsVac is used to simplify the query structure and improve readability.
CTEs are especially useful for complex queries and calculations.

Temporary Table (#PercentPopulationVaccinated):
-
A temporary table is created to store intermediate results (#PercentPopulationVaccinated).
This table is then queried to calculate the percentage of the population vaccinated.

View Creation:
-
A view (PercentPopulationVaccinated) is created to store the result set of the main query for potential later visualization or reuse.
Views provide a way to abstract the underlying complexity of queries.

Data Type Considerations:
-
Data types are chosen based on the nature of the data, with considerations for numeric precision. 
For example, using numeric for population and new vaccination columns.

Error Handling:
-
The code includes a DROP TABLE IF EXISTS statement to ensure that the temporary table (#PercentPopulationVaccinated) 
is dropped if it already exists. This prevents errors during repeated executions.

SQL Best Practices:
-
The code follows SQL best practices, such as using proper indentation, commenting, and logical structuring. The use of meaningful aliases (dea and vac) enhances code readability.
