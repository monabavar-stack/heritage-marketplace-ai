-- Heritage Marketplace AI - Complete BigQuery Implementation
-- "Where Every Purchase Preserves a Story"

-- Step 1: Create Customer Desires Table
CREATE OR REPLACE TABLE `lithe-key-469707-a3.marketplace_data.customer_desires` (
  customer_id STRING,
  background STRING,
  cultural_desire STRING,
  emotional_goal STRING,
  full_narrative STRING
);

-- Step 2: Insert Customer Data
INSERT INTO `lithe-key-469707-a3.marketplace_data.customer_desires` VALUES
('CUST_001', 
 'Second-generation Iranian-American planning her mother\'s 70th birthday',
 'Reflects Persian poetry and calligraphy traditions',
 'To honor her mother\'s heritage and create a sense of continuity between generations',
 'A customer wants to find a handcrafted piece for her mother\'s 70th birthday. She is looking for something that reflects Persian poetry and calligraphy traditions, carrying both cultural depth and a feeling of legacy.'),

('CUST_002',
 'Young couple preparing for a cross-cultural wedding (Japanese–Italian)',
 'Blends Japanese minimalist aesthetics with Italian artisanal craft',
 'To symbolize unity between their two families and cultures',
 'A couple wants to find tableware for their wedding. They are looking for something that blends Japanese minimalist aesthetics with Italian artisanal craft, creating a sense of harmony and shared tradition.'),

('CUST_003',
 'Corporate client organizing a milestone celebration for international partners',
 'Showcases traditional craftsmanship from diverse cultures while carrying message of sustainability',
 'To express respect and create lasting impressions through authentic cultural objects',
 'A company wants to find gifts for their global partners. They are looking for something that showcases traditional craftsmanship from diverse cultures while carrying a message of sustainability and cultural respect.');

-- Step 3: Create Artisan Stories Table  
CREATE OR REPLACE TABLE `lithe-key-469707-a3.marketplace_data.artisan_stories` (
  artisan_id STRING,
  background STRING,
  techniques STRING,
  cultural_philosophy STRING,
  specialty STRING,
  full_story STRING
);

-- Step 4: Insert Artisan Data
INSERT INTO `lithe-key-469707-a3.marketplace_data.artisan_stories` VALUES
('ART_001',
 'Third-generation Persian calligrapher from Isfahan',
 'Hand-inks his own tools and papers, following centuries-old calligraphy traditions',
 'Believes each stroke preserves a sacred link between word, art, and spirit',
 'Creates bespoke calligraphy pieces that integrate poetry into decorative objects',
 'A third-generation Persian calligrapher from Isfahan who hand-inks his own tools and papers, following centuries-old calligraphy traditions. He believes each stroke preserves a sacred link between word, art, and spirit, creating bespoke calligraphy pieces that integrate poetry into decorative objects.'),

('ART_002', 
 'Japanese metalworker from Kyoto trained in traditional mokume-gane (wood-grain metal) techniques',
 'Layers metals by hand to create patterns resembling natural forms',
 'Embodies wabi-sabi, finding beauty in imperfection and simplicity',
 'Minimalist jewelry and tableware with organic patterns that blend tradition with modern design',
 'A Japanese metalworker from Kyoto trained in traditional mokume-gane (wood-grain metal) techniques. He layers metals by hand to create patterns resembling natural forms, embodying wabi-sabi and finding beauty in imperfection and simplicity. His specialty is minimalist jewelry and tableware with organic patterns that blend tradition with modern design.'),

('ART_003',
 'Italian glassmaker from Murano whose family has worked with glass for centuries', 
 'Hand-blows glass using traditional furnaces, combining modern shapes with historic methods',
 'Believes glass carries both fragility and strength, symbolizing human connection',
 'Limited-edition tableware and sculptural objects for ceremonial occasions',
 'An Italian glassmaker from Murano whose family has worked with glass for centuries. He hand-blows glass using traditional furnaces, combining modern shapes with historic methods. He believes glass carries both fragility and strength, symbolizing human connection, specializing in limited-edition tableware and sculptural objects for ceremonial occasions.');

-- Step 5: Create Cultural Matching Algorithm
CREATE OR REPLACE TABLE `lithe-key-469707-a3.marketplace_data.cultural_matches` AS
SELECT 
  cd.customer_id,
  cd.background as customer_background,
  SUBSTR(cd.full_narrative, 1, 100) as customer_desire,
  ast.artisan_id,
  ast.background as artisan_background, 
  SUBSTR(ast.full_story, 1, 100) as artisan_story,
  -- Cultural matching score based on heritage alignment
  CASE 
    WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'persian|iranian') 
         AND REGEXP_CONTAINS(LOWER(ast.full_story), r'persian|iranian') THEN 0.95
    WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'japanese') 
         AND REGEXP_CONTAINS(LOWER(ast.full_story), r'japanese') THEN 0.90
    WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'italian') 
         AND REGEXP_CONTAINS(LOWER(ast.full_story), r'italian') THEN 0.85
    WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'craft|artisan|traditional') 
         AND REGEXP_CONTAINS(LOWER(ast.full_story), r'craft|artisan|traditional') THEN 0.70
    WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'minimalist|simple') 
         AND REGEXP_CONTAINS(LOWER(ast.full_story), r'minimalist|simple|wabi-sabi') THEN 0.75
    ELSE 0.30
  END as cultural_match_score,
  ROW_NUMBER() OVER (PARTITION BY cd.customer_id ORDER BY 
    CASE 
      WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'persian|iranian') 
           AND REGEXP_CONTAINS(LOWER(ast.full_story), r'persian|iranian') THEN 0.95
      WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'japanese') 
           AND REGEXP_CONTAINS(LOWER(ast.full_story), r'japanese') THEN 0.90
      WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'italian') 
           AND REGEXP_CONTAINS(LOWER(ast.full_story), r'italian') THEN 0.85
      WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'craft|artisan|traditional') 
           AND REGEXP_CONTAINS(LOWER(ast.full_story), r'craft|artisan|traditional') THEN 0.70
      WHEN REGEXP_CONTAINS(LOWER(cd.full_narrative), r'minimalist|simple') 
           AND REGEXP_CONTAINS(LOWER(ast.full_story), r'minimalist|simple|wabi-sabi') THEN 0.75
      ELSE 0.30
    END DESC) as match_rank
FROM `lithe-key-469707-a3.marketplace_data.customer_desires` cd
CROSS JOIN `lithe-key-469707-a3.marketplace_data.artisan_stories` ast
ORDER BY cd.customer_id, cultural_match_score DESC;

-- Step 6: Demo Query - Show Perfect Cultural Match
SELECT 
  'Persian Heritage Match' as demo_name,
  'Customer wants: Persian poetry and calligraphy traditions' as customer_need,
  'Artisan offers: Persian calligrapher who integrates poetry into decorative objects' as artisan_specialty,
  '0.95' as match_score,
  'PERFECT MATCH - Both share Persian cultural heritage' as explanation
FROM `lithe-key-469707-a3.marketplace_data.cultural_matches`
WHERE customer_id = 'CUST_001' AND match_rank = 1;


  -- Advanced Analysis: Cultural Heritage Impact
-- Analyzes cultural preservation effectiveness across different heritage types
WITH heritage_analysis AS (
  SELECT 
    CASE 
      WHEN REGEXP_CONTAINS(LOWER(ast.background), r'persian|iranian') THEN 'Persian'
      WHEN REGEXP_CONTAINS(LOWER(ast.background), r'japanese') THEN 'Japanese'
      WHEN REGEXP_CONTAINS(LOWER(ast.background), r'italian') THEN 'Italian'
      ELSE 'Other'
    END AS heritage_type,
    COUNT(DISTINCT cm.customer_id) as customers_reached,
    AVG(cm.cultural_match_score) as avg_cultural_alignment,
    COUNT(DISTINCT ast.artisan_id) as artisans_supported
  FROM `lithe-key-469707-a3.marketplace_data.cultural_matches` cm
  JOIN `lithe-key-469707-a3.marketplace_data.artisan_stories` ast ON cm.artisan_id = ast.artisan_id
  WHERE cm.cultural_match_score > 0.7
  GROUP BY heritage_type
)
SELECT 
  heritage_type,
  customers_reached,
  artisans_supported,
  ROUND(avg_cultural_alignment, 3) as cultural_preservation_score,
  customers_reached * artisans_supported as heritage_network_impact
FROM heritage_analysis
ORDER BY heritage_network_impact DESC;


  
