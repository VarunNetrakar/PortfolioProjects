
Select *
From PortfolioProject..coviddeaths
Where continent is not NULL
Order by 3,4

--Select *
--From PortfolioProject..covidvaccinations
--Order by 3,4

Select Location, date, total_cases, new_cases, total_deaths, population 
From PortfolioProject..coviddeaths
Order by 1,2


-- Looking at Total Cases vs Total Deaths

Select Location, date, total_cases,total_deaths
From PortfolioProject..coviddeaths
Order by 1,2


-- Looking at Total Cases vs Population
-- Show the percentage of population got covid

Select Location, date, total_cases,population
From PortfolioProject..coviddeaths
Order by 1,2


-- Looking at countries with Highest Infection Rate Compared to Population

Select Location, date, (total_cases) as HigestInfectionCount, population
PercentagePopulationInfected
From PortfolioProject..coviddeaths
Where continent is not NULL
Order by PercentagePopulationInfected desc


-- Showing Countried with Highest Death Count per Population

Select Location, MAX(total_deaths) as TotalDeathCount
From PortfolioProject..coviddeaths
Group by location
Order by TotalDeathCount desc


-- LET'S BREAK THINGS DOWN BY CONTINENT


Select Location, continent, MAX(total_cases) as HigestInfectionCount, population
PercentagePopulationInfected
From PortfolioProject..coviddeaths
Where continent is not NULL
Group by continent
Order by PercentagePopulationInfected desc


-- Showing continents with the highest death count per population

Select continent, MAX(total_deaths) as TotalDeathCount
From PortfolioProject..coviddeaths
Group by continent
Order by TotalDeathCount desc


-- Global Numbers

Select date, (new_cases) as HighestInfectionCount, population
From PortfolioProject..coviddeaths
Where continent is not NULL
Order by 1,2


-- Looking at Total Population vs Vaccinations 


Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
    On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not NULL
Order by 1,2,3

    

-- TEMP TABLE

DROP Table If exists #PercentagePopulationVaccinated
Create Table #PercentagePopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
)

Insert into #PercentagePopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
    On dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not NULL
--Order by 1,2,3


-- Creating view for later visualizations

Create view PercentagePopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
From PortfolioProject..coviddeaths dea
Join PortfolioProject..covidvaccinations vac
    On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not NULL
--Order by 1,2,3


Select *
From PercentagePopulationVaccinated