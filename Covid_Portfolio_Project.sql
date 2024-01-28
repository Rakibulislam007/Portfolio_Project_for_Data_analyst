--pulling up the database to validate
SELECT * 
FROM Portpolio_project..covid_deaths
Where continent is not null
order by 3,4

--SELECT * 
--FROM Portpolio_project..covid_vaccination
--order by 3,4

--selecting the necessery data

Select location, date, total_cases, new_cases, total_deaths, population 
From Portpolio_project..covid_deaths

order by 1,2

--looking at total cases vs total deaths for death percentage
--shows the likelihood of dying in the area
Select location, date, total_cases, total_deaths, (CAST(total_deaths AS float)/ CAST (total_cases AS float))*100 as DeathPercentage
From Portpolio_project..covid_deaths
where location like '%Bangladesh%'
order by 1,2

--looking at total cases vs population
--shows the percentage of population got covid
Select location, date, total_cases, population, (total_cases / population)*100 as populationInfectedPercentage
From Portpolio_project..covid_deaths
where location like '%Bangladesh%'
order by 1,2

--looking at countries with highest infection rate to population

Select location, population,  Max(total_cases) as HighestInfectionCount, MAX((total_cases / population))*100 as populationInfectedPercentage
From Portpolio_project..covid_deaths
GROUP BY location, population
order by 4 desc

--lookig at higest deathcount per population

Select location, Max(cast (total_deaths as int)) as TotalDeathCount
From Portpolio_project..covid_deaths
Where continent is not null
GROUP BY location
order by 2 desc

--Looking at by continent

Select continent, Max(cast (total_deaths as int)) as TotalDeathCount
From Portpolio_project..covid_deaths
Where continent is not null
GROUP BY continent
order by 2 desc

--Global numbers

Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
From Portpolio_project..covid_deaths
Where continent is not null
--GROUP BY date
order by 1,2

--Looking at Total population vs vaccinations

SELECT dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccination
From Portpolio_project..covid_deaths dea
join Portpolio_project..covid_vaccination vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3

--use CTE
With PopvsVac (continent, location, Date, Population, New_Vaccination, RollingPeopleVaccination)
as
(

Select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccination
From Portpolio_project..covid_deaths dea
join Portpolio_project..covid_vaccination vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null

)

SELECT *, (RollingPeopleVaccination/population)*100
From PopvsVac


--TEMP table
DROP Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccination numeric,
RollingPeopleVaccination numeric
)


Insert into #PercentPopulationVaccinated

Select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccination
From Portpolio_project..covid_deaths dea
join Portpolio_project..covid_vaccination vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null



SELECT *, (RollingPeopleVaccination/population)*100
From #PercentPopulationVaccinated


--creating view to store data for later visualisation
Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
, SUM(Cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccination
From Portpolio_project..covid_deaths dea
join Portpolio_project..covid_vaccination vac
On dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null