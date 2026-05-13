-- Sandy Beach Invertebrate and Shorebird Analysis --
-- Question: Do sites with higher invertebrate biomass support greater shorebird abudnace?

-- Tables that hold this information ---
-- Invertebrates has invertebrate biomass and sites
-- Shorebirds has species, count, and sites
--  Join kEY is site

-- Simple database check 
-- Check column types

DESCRIBE invertebrates;
DESCRIBE shorebirds;

-- Spot check data
SELECT * FROM invertebrates LIMIT 5;
SELECT * FROM shorebirds LIMIT 5;

-- Confirm all 24 sites loaded
SELECT COUNT(*) FROM invertebrates;
SELECT COUNT(*) FROM shorebirds;

-- Verify no orphaned rows (sites that don't match across tables)
SELECT DISTINCT site FROM invertebrates
WHERE site NOT IN (SELECT site FROM shorebirds);

SELECT DISTINCT site FROM shorebirds
WHERE site NOT IN (SELECT site FROM invertebrates);

---- Analytical Query ----
-- Aggregate invertebrate biomass and shorebird counts
-- per site using subqueries to avoid row multiplication
-- from a direct JOIN, then join on share site key. 

SELECT i.site,
       i.total_biomass,
       b.total_birds
FROM (
    -- Total invertebrate biomass per site
    SELECT site, SUM(biomass) AS total_biomass
    FROM invertebrates
    GROUP BY site
) i
JOIN (
     -- Total shorebird count per site
    SELECT site, SUM(count) AS total_birds
    FROM shorebirds
    GROUP BY site
) b ON i.site = b.site
ORDER BY total_biomass DESC;

-- Initial query -- produced inflated values due to row 
-- multiplication from joining before aggregating
-- SELECT i.site, 
--        SUM(i.biomass) AS total_biomass,
--        SUM(b.count)   AS total_birds
-- FROM invertebrates i
-- JOIN shorebirds b ON i.site = b.site
-- GROUP BY i.site
-- ORDER BY total_biomass DESC;