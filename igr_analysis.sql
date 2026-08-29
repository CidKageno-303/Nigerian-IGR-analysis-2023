-- NIGERIAN STATES IGR 2023 - MySQL Data Warehouse
-- Full 37 States + FCT from JTB Excel Data


USE igr_analytics;

-- 1. CLEAN SLATE: Drop everything
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS fact_igr;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_state;
SET FOREIGN_KEY_CHECKS = 1;


-- 2. CREATE TABLES

CREATE TABLE dim_state (
    state_id    INT PRIMARY KEY,
    state_name  VARCHAR(50) NOT NULL,
    state_code  VARCHAR(10) NOT NULL,
    region      VARCHAR(50) NOT NULL
);

CREATE TABLE dim_date (
    date_id      INT PRIMARY KEY,
    year         INT NOT NULL,
    period_label VARCHAR(50)
);

-- Wide fact table: one row per state, all tax types as columns
CREATE TABLE fact_igr (
    fact_id             INT AUTO_INCREMENT PRIMARY KEY,
    state_id            INT NOT NULL,
    date_id             INT NOT NULL,
    paye                DECIMAL(18,2),
    direct_assessment   DECIMAL(18,2),
    road_tax            DECIMAL(18,2),
    stamp_duties        DECIMAL(18,2),
    capital_gains_tax   DECIMAL(18,2),
    withholding_tax     DECIMAL(18,2),
    other_tax           DECIMAL(18,2),
    lga_revenue         DECIMAL(18,2),
    total_tax           DECIMAL(18,2),
    mdas_revenue        DECIMAL(18,2),
    total_revenue       DECIMAL(18,2)
);

-- ============================================================
-- 3. INSERT DIMENSION DATA
-- ============================================================

INSERT INTO dim_state (state_id, state_name, state_code, region) VALUES
(1, 'Lagos', 'LAG', 'South-West'),
(2, 'FCT', 'FCT', 'North-Central'),
(3, 'Rivers', 'RIV', 'South-South'),
(4, 'Ogun', 'OGU', 'South-West'),
(5, 'Delta', 'DEL', 'South-South'),
(6, 'Edo', 'EDO', 'South-South'),
(7, 'Kaduna', 'KAD', 'North-West'),
(8, 'Kwara', 'KWA', 'North-Central'),
(9, 'Oyo', 'OYO', 'South-West'),
(10, 'Akwa Ibom', 'AKI', 'South-South'),
(11, 'Ondo', 'OND', 'South-West'),
(12, 'Kano', 'KAN', 'North-West'),
(13, 'Enugu', 'ENU', 'South-East'),
(14, 'Anambra', 'ANA', 'South-East'),
(15, 'Ekiti', 'EKI', 'South-West'),
(16, 'Cross River', 'CRI', 'South-South'),
(17, 'Ebonyi', 'EBO', 'South-East'),
(18, 'Bauchi', 'BAU', 'North-East'),
(19, 'Osun', 'OSU', 'South-West'),
(20, 'Jigawa', 'JIG', 'North-West'),
(21, 'Katsina', 'KAT', 'North-West'),
(22, 'Kogi', 'KOG', 'North-Central'),
(23, 'Plateau', 'PLA', 'North-Central'),
(24, 'Nasarawa', 'NAS', 'North-Central'),
(25, 'Abia', 'ABI', 'South-East'),
(26, 'Zamfara', 'ZAM', 'North-West'),
(27, 'Niger', 'NIG', 'North-Central'),
(28, 'Imo', 'IMO', 'South-East'),
(29, 'Bayelsa', 'BAY', 'South-South'),
(30, 'Borno', 'BOR', 'North-East'),
(31, 'Benue', 'BEN', 'North-Central'),
(32, 'Sokoto', 'SOK', 'North-West'),
(33, 'Adamawa', 'ADA', 'North-East'),
(34, 'Gombe', 'GOM', 'North-East'),
(35, 'Kebbi', 'KEB', 'North-West'),
(36, 'Yobe', 'YOB', 'North-East'),
(37, 'Taraba', 'TAR', 'North-East');

INSERT INTO dim_date (date_id, year, period_label) VALUES
(2023, 2023, 'FY 2023 Full Year');


-- 4. INSERT FACT DATA (2023 - All 37 States + FCT)

INSERT INTO fact_igr (state_id, date_id, paye, direct_assessment, road_tax, stamp_duties, capital_gains_tax, withholding_tax, other_tax, lga_revenue, total_tax, mdas_revenue, total_revenue) VALUES
(1, 2023, 444732776477.88, 33398071605.48, 16744398879.59, 5513817943.38, 1759071995.67, 131935578509.97, 60321339262.33, 10496249633.55, 704901304307.85, 110963375663.42, 815864679971.27),
(2, 2023, 130111653706.04, 2871447664.05, 0.00, 46398450.32, 92146054.19, 12762501119.59, 65216141142.17, 0.00, 211100288136.36, 0.00, 211100288136.36),
(3, 2023, 143016298425.77, 858071344.89, 830010680.00, 162923589.78, 294938713.57, 9803329008.87, 32001970050.21, 0.00, 186967541813.09, 8447039772.25, 195414581585.34),
(4, 2023, 53179241120.95, 2295299834.10, 1644650359.25, 963198222.74, 532384189.68, 10413139482.39, 1337163442.50, 1312924547.12, 71678001198.73, 75197040276.63, 146875041475.36),
(5, 2023, 71654730735.22, 530274691.49, 2601537170.66, 2351247783.50, 6074489.49, 13270082181.93, 497729672.63, 0.00, 90911676724.92, 23176632500.07, 114088309224.99),
(6, 2023, 26973179498.38, 1943685628.23, 1592449114.00, 103900203.36, 61270645.30, 4808951992.49, 8094504593.70, 2592374073.41, 46170315748.87, 18501181612.90, 64671497361.77),
(7, 2023, 23568560576.88, 353823159.39, 622994303.52, 4167086058.39, 0.00, 2846829598.32, 17083656852.52, 382217508.42, 49025168057.44, 13464949577.78, 62490117635.22),
(8, 2023, 11448918904.82, 472487391.33, 607266763.67, 4931811304.55, 8625912.88, 1411866661.10, 894202925.12, 3354331788.59, 23129511652.06, 36513166467.77, 59642678119.83),
(9, 2023, 29625615844.36, 1085978951.74, 628794596.77, 1656710942.57, 171798735.60, 3406031437.97, 837146130.17, 3114443400.52, 40526520039.70, 12218977019.34, 52745497059.04),
(10, 2023, 25840325732.44, 82405467.65, 528769342.63, 4411256285.32, 0.00, 2660220416.72, 2206119527.37, 343175922.00, 36072272694.13, 7111751932.64, 43184024626.77),
(11, 2023, 16369837042.46, 858347743.99, 1593256427.51, 3481992804.11, 64245900.93, 1777719362.45, 10036851878.86, 1390542319.38, 35572793479.69, 5928757907.67, 41501551387.36),
(12, 2023, 19612062308.32, 745679534.00, 967169150.95, 4236791.28, 30610374.26, 3065453322.27, 6108732217.62, 0.00, 30533943698.70, 6845676299.56, 37379619998.26),
(13, 2023, 13262243559.45, 137068497.58, 53474636.09, 0.00, 35059968.00, 2354034812.00, 7060449414.74, 0.00, 22902330887.86, 10960609969.88, 33862940857.74),
(14, 2023, 15797207193.28, 804039743.43, 696574429.00, 91035901.90, 973645636.56, 4045709134.08, 922039548.32, 0.00, 23330251586.57, 10131116973.86, 33461368560.43),
(15, 2023, 7104857692.70, 586319318.21, 263425198.38, 30491293.29, 2626988.52, 1030478372.73, 6587921361.59, 303645428.15, 15909765653.57, 16186284662.53, 32096050316.10),
(16, 2023, 9243212523.99, 151602606.46, 1220071588.63, 1342766696.24, 416319.52, 1055192723.06, 9985541890.90, 701342685.00, 23700147033.80, 7860432723.75, 31560579757.55),
(17, 2023, 4957608142.91, 993786711.15, 2848292695.03, 37885332.71, 851634513.05, 1875999838.89, 3960353703.69, 6125963737.57, 21651524675.00, 9188945606.40, 30840470281.40),
(18, 2023, 15019307044.39, 980333090.14, 448278975.00, 0.00, 0.00, 0.00, 4729707136.21, 250366129.05, 21427992374.79, 9156933375.82, 30584925750.61),
(19, 2023, 11374092096.13, 353167566.96, 424678866.85, 12445043.92, 26435001.07, 1052586978.78, 216114117.36, 204415525.82, 13663935196.89, 14261101958.28, 27925037155.17),
(20, 2023, 9821399355.59, 227707191.82, 161137093.00, 86782841.78, 18332802.96, 2320433501.21, 2362192295.40, 2895249447.56, 17893234529.32, 9642956634.51, 27536191163.83),
(21, 2023, 11232948182.52, 556639388.25, 29296809.90, 0.00, 0.00, 107826067.31, 14693623121.29, 0.00, 26620333569.27, 336276566.41, 26956610135.68),
(22, 2023, 11484320303.70, 139376101.46, 628674100.00, 65864695.98, 269699.99, 1899539132.40, 6589813845.24, 289730905.67, 21097588784.44, 5682881596.62, 26780470381.06),
(23, 2023, 14708443687.78, 66636560.02, 612023888.58, 24134285.68, 18844948.74, 1238793324.93, 369195842.58, 0.00, 17038072538.31, 8806859137.14, 25844931675.45),
(24, 2023, 8548543655.69, 72871844.24, 208021707.75, 13685974.26, 0.00, 599130423.26, 3757919583.20, 0.00, 13200173188.40, 10287261848.89, 23487435037.29),
(25, 2023, 7555775156.83, 347012029.87, 441904080.08, 520595769.16, 668600688.76, 2034854001.06, 3423968345.08, 341742137.71, 15334452208.55, 8399397900.70, 23733850109.25),
(26, 2023, 11209040552.42, 1905153918.64, 1613869517.38, 0.00, 0.00, 0.00, 3894016849.57, 0.00, 18622080838.01, 3540509972.58, 22162590810.59),
(27, 2023, 9739641273.52, 797419736.80, 190492103.00, 0.00, 0.00, 0.00, 10035969247.56, 0.00, 20763522360.88, 911868698.23, 21675391059.11),
(28, 2023, 8148776173.82, 361662566.62, 691757914.84, 75901224.65, 249767697.06, 1958569016.90, 3914206006.72, 215340810.21, 15615981410.82, 5435331880.40, 21051313291.22),
(29, 2023, 14065810776.66, 21742981.56, 146595366.74, 114552941.37, 9098835.98, 1657103352.21, 2636679029.93, 0.00, 18651583284.45, 1172037625.40, 19823620909.85),
(30, 2023, 9837750196.99, 164731783.13, 212499146.25, 29710364.72, 16398861.88, 1765149893.29, 4244395576.10, 213118935.00, 16483754757.36, 2970273656.93, 19454028414.29),
(31, 2023, 10417759632.72, 2328613727.00, 191226560.00, 17268893.70, 4171432.04, 652617713.31, 502736396.22, 0.00, 14114394354.99, 5001961567.47, 19116355922.46),
(32, 2023, 9578455705.83, 16022443.58, 194657996.00, 10443863.84, 0.00, 871854386.61, 4583261354.10, 0.00, 15254695749.96, 2706638695.34, 17961334445.30),
(33, 2023, 9137282067.76, 99506124.22, 120640919.74, 3207300.00, 2284971.90, 2219073574.00, 608347408.82, 0.00, 12190342366.44, 4875847609.40, 17066189975.84),
(34, 2023, 9401943913.66, 25461602.54, 135993640.02, 6744200.00, 10836113.44, 223757007.25, 126854530.64, 2085915213.27, 12017506220.82, 3161543959.43, 15179050180.25),
(35, 2023, 5076851323.73, 719939999.28, 51853075.00, 1834558.60, 0.00, 0.00, 4408482577.11, 0.00, 10258961533.72, 1478114175.28, 11737075709.00),
(36, 2023, 4910206933.99, 45629445.00, 81884680.00, 1865317.92, 0.00, 412334388.29, 1347131725.02, 0.00, 6799052490.22, 4395668792.64, 11194721282.86),
(37, 2023, 6271924307.43, 17736209.83, 110571800.00, 7852607.29, 45000.00, 331541509.81, 590785946.71, 441000771.00, 7771458152.07, 3097720191.87, 10869178343.94);


-- 5. CREATE REPORTING VIEWS

-- View 1: State Revenue Summary
DROP VIEW IF EXISTS vw_state_revenue_summary;
CREATE VIEW vw_state_revenue_summary AS
SELECT 
    s.state_id,
    s.state_name,
    s.state_code,
    s.region,
    f.paye,
    f.direct_assessment,
    f.road_tax,
    f.stamp_duties,
    f.capital_gains_tax,
    f.withholding_tax,
    f.other_tax,
    f.lga_revenue,
    f.total_tax,
    f.mdas_revenue,
    f.total_revenue,
    RANK() OVER (ORDER BY f.total_revenue DESC) AS revenue_rank
FROM dim_state s
JOIN fact_igr f ON s.state_id = f.state_id;

-- View 2: Regional Aggregation
DROP VIEW IF EXISTS vw_regional_summary;
CREATE VIEW vw_regional_summary AS
SELECT 
    s.region,
    COUNT(*) AS number_of_states,
    SUM(f.paye) AS paye,
    SUM(f.direct_assessment) AS direct_assessment,
    SUM(f.road_tax) AS road_tax,
    SUM(f.stamp_duties) AS stamp_duties,
    SUM(f.capital_gains_tax) AS capital_gains_tax,
    SUM(f.withholding_tax) AS withholding_tax,
    SUM(f.other_tax) AS other_tax,
    SUM(f.lga_revenue) AS lga_revenue,
    SUM(f.total_tax) AS total_tax,
    SUM(f.mdas_revenue) AS mdas_revenue,
    SUM(f.total_revenue) AS total_revenue
FROM dim_state s
JOIN fact_igr f ON s.state_id = f.state_id
GROUP BY s.region
ORDER BY total_revenue DESC;

-- View 3: Tax Type Performance (National Totals)
DROP VIEW IF EXISTS vw_tax_type_national;
CREATE VIEW vw_tax_type_national AS
SELECT 'PAYE' AS tax_type, SUM(paye) AS total_amount FROM fact_igr
UNION ALL
SELECT 'Direct Assessment', SUM(direct_assessment) FROM fact_igr
UNION ALL
SELECT 'Road Tax', SUM(road_tax) FROM fact_igr
UNION ALL
SELECT 'Stamp Duties', SUM(stamp_duties) FROM fact_igr
UNION ALL
SELECT 'Capital Gains Tax', SUM(capital_gains_tax) FROM fact_igr
UNION ALL
SELECT 'Withholding Tax', SUM(withholding_tax) FROM fact_igr
UNION ALL
SELECT 'Other Tax', SUM(other_tax) FROM fact_igr
UNION ALL
SELECT 'LGA Revenue', SUM(lga_revenue) FROM fact_igr
UNION ALL
SELECT 'MDAs Revenue', SUM(mdas_revenue) FROM fact_igr
ORDER BY total_amount DESC;

-- View 4: Top 10 States
DROP VIEW IF EXISTS vw_top_10_states;
CREATE VIEW vw_top_10_states AS
SELECT 
    s.state_name,
    s.region,
    f.total_revenue,
    RANK() OVER (ORDER BY f.total_revenue DESC) AS rank_position,
    f.total_revenue / (SELECT SUM(total_revenue) FROM fact_igr) * 100 AS pct_of_national
FROM dim_state s
JOIN fact_igr f ON s.state_id = f.state_id
ORDER BY f.total_revenue DESC
LIMIT 10;

-- View 5: Revenue Composition by State (Percentages)
DROP VIEW IF EXISTS vw_revenue_composition;
CREATE VIEW vw_revenue_composition AS
SELECT 
    s.state_name,
    s.region,
    f.total_revenue,
    f.paye / f.total_revenue * 100 AS paye_pct,
    f.direct_assessment / f.total_revenue * 100 AS da_pct,
    f.road_tax / f.total_revenue * 100 AS road_tax_pct,
    f.stamp_duties / f.total_revenue * 100 AS stamp_pct,
    f.capital_gains_tax / f.total_revenue * 100 AS cgt_pct,
    f.withholding_tax / f.total_revenue * 100 AS wht_pct,
    f.other_tax / f.total_revenue * 100 AS other_tax_pct,
    f.lga_revenue / f.total_revenue * 100 AS lga_pct,
    f.mdas_revenue / f.total_revenue * 100 AS mdas_pct
FROM dim_state s
JOIN fact_igr f ON s.state_id = f.state_id;


-- 6. VERIFY

SELECT 
    (SELECT COUNT(*) FROM dim_state) AS states,
    (SELECT COUNT(*) FROM dim_date) AS dates,
    (SELECT COUNT(*) FROM fact_igr) AS facts,
    (SELECT SUM(total_revenue) FROM fact_igr) AS national_total;